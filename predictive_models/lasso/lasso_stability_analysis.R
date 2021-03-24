rm(list=ls())

#Load data
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/new_5.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/MATCHIT.rds")
matched <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])

#load packages
library(caTools)
library(glmnet)
library(dplyr)
library(ROCR)

#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- data[data[,1] == 0, ]
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split,]
matched_80<- matched[matched$control %in% rownames(controls_80), ]
matched_20 <- matched[!(matched$control %in% rownames(controls_80)), ]
train <- data[c(matched_80[,1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]
y_train <- train[, 1]
X_train <- as.matrix(train[,-1])
y_test <- test[,1]
X_test <- as.matrix(test[,-1])

#Stability analysis
stability <- 100 ###Change value for stability analysis (100?)
lasso_coef <- rep(0, length=ncol(X_train))
for(i in 1:stability){
  #Fold
  k <- 10 #k-fold cross validation
  set.seed(i)
  matched_80$fold <- sample(rep(1:k, length=length(matched_80[,1]/2)))
  fold <- data.frame("ids" = c(matched_80$case, matched_80$control), "fold_ids" = c(matched_80$fold, matched_80$fold))
  fold <- fold[order(fold$ids),]
  #Lasso
  lasso_stab <- cv.glmnet(X_train, y_train, family = "binomial", type.measure = "auc", foldid = fold$fold_ids)
  coef.sub = coef(lasso_stab, s = "lambda.1se")[-1]
  coef_it <- coef.sub/coef.sub
  coef_it[is.nan(coef_it)] <- 0
  lasso_coef <- lasso_coef + coef_it
}


#Bar plot of comorbidity selection
lasso.prop = lasso_coef/stability
names(lasso.prop) <- colnames(X_train)
lasso_coef = sort(lasso.prop, decreasing = TRUE)
pdf("stability_analysis_lasso5.pdf")
plot(lasso.prop[lasso.prop > 0.2], type = "h", col = "navy",
     lwd = 3, xaxt = "n", xlab = "", ylab = expression(beta),
     ylim = c(0, 1.2), las = 1)
text(lasso.prop[lasso.prop > 0.2] + 0.07, labels = names(lasso.prop[lasso.prop > 0.2]), pos = 3, srt = 90, cex = 0.7)
dev.off()


