rm(list=ls())

#Load data
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/new_1.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])

#load packages
library(caTools)
library(glmnet)
library(dplyr)
library(ROCR)

#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)

cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]

#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

#Fold
k <- 10 #k-fold cross validation
set.seed(2)
matched_80$fold <- sample(rep(1:k, length=length(matched_80[,1])))
fold <- data.frame("ids" = c(matched_80$case, matched_80$control), "fold_ids" = c(matched_80$fold, matched_80$fold))
print("fold")

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

#check order of train and fold$ids
sum(fold$ids == rownames(X_train))


#LASSO model

cv_lasso <- cv.glmnet(X_train, y_train, family = "binomial", type.measure = "auc", foldid = fold$fold_ids)
print("cv.glmnet")
#See comorbidities that where selected
cv_lasso$lambda.1se
coefficients_logit_1se <- coef(cv_lasso, s=cv_lasso$lambda.1se)
non_zero_index <- coefficients_logit_1se@i
non_zero_coefficients <- coefficients_logit_1se@x
comorbidities <- cbind(c("Intercept",colnames(data)[non_zero_index]),non_zero_coefficients)
saveRDS(comorbidities, "/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected_scale21.rds")
#Performance evaluation

predict_lasso <- predict(cv_lasso, newx = X_test, type = "response", s = cv_lasso$lambda.1se)
print("prediction")
#confusion matrix
confusion_matrix <- table(y_test, predict_lasso > 0.5)
saveRDS(confusion_matrix, "/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/confusion_matrix_scale21.rds")
pr_lasso <- prediction(predict_lasso, y_test)
prf_lasso <- performance(pr_lasso, measure = "tpr", x.measure = "fpr")
saveRDS(prf_lasso, "/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/prf_scale21.rds")
#AUC
auc_lasso <- as.numeric(performance(pr_lasso, measure = "auc")@y.values)
saveRDS(auc_lasso, "/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc_scale21.rds")
#ROCR curve
pdf("ROCR_curve_lasso_scale21.pdf")
plot(prf_lasso, colorize=TRUE)
dev.off()

