rm(list=ls())

## Parameters

args=commandArgs(trailingOnly=TRUE)
nchunks=as.numeric(args[1])
ichunk=as.numeric(args[2])

#Load data
test <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test1.rds")
train <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train1.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
matched_80 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/matched_80.rds")
matched_20 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/matched_20.rds")

#load packages
library(caTools)
library(glmnet)
library(dplyr)
library(ROCR)

#separte into X and y
y_train <- train[, 1]
X_train <- as.matrix(train[,-1])
y_test <- test[, 1]
X_test <- as.matrix(test[,-1])

#scale
X_train <- scale(X_train)
X_test <- scale(X_test)

X_train <- scale(X_train)
drop_train <- which(is.nan(X_train[1,]))
X_train[, drop_train] <- 0

X_test <- scale(X_test)
drop_test <- which(is.nan(X_test[1,]))
X_test[, drop_test] <- 0

lasso_coef <- rep(0, length=(ncol(X_train)))
for(l in 1:10){
  
  i <- l + (10 * (ichunk - 1))

#Fold
k <- 10 #k-fold cross validation
set.seed(i)
matched_80$fold <- sample(rep(1:k, length=length(matched_80[,1])))
fold <- data.frame("ids" = c(matched_80$case, matched_80$control), "fold_ids" = c(matched_80$fold, matched_80$fold))
print("fold")
#LASSO model

lasso_stab <- cv.glmnet(X_train, y_train, family = "binomial", type.measure = "auc", foldid = fold$fold_ids)
coef.sub = coef(lasso_stab, s = "lambda.1se")[-1]
coef_it <- coef.sub/coef.sub
coef_it[is.nan(coef_it)] <- 0
lasso_coef <- lasso_coef + coef_it
}

saveRDS(lasso_coef, paste0("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/Lasso_stab_comor1/Lasso_stab_comor1_scaled_", ichunk, ".rds"))
