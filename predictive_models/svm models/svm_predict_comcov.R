rm(list=ls())

# Load relevant packages
if(!require(e1071)) install.packages("e1071", repos = "http://cran.us.r-project.org")
if(!require(caret)) install.packages("caret", repos = "http://cran.us.r-project.org")
if(!require(pROC)) install.packages("pROC", repos = "http://cran.us.r-project.org")
library(e1071)
library(caret)
library(dplyr)
library(tidyverse)
library(caTools)
library(pROC)

train5_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_comcov.rds")
test5_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_comcov.rds")
train1_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm_comcov.rds")
test1_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm_comcov.rds")


load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_comcov.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_comcov.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_comcov_rad.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_comcov_rad.rda")

# Predict fit on test
y_pred_svmfit5_comcov = predict(svmfit5_comcov, newdata = test5_comcov[,-1])
y_pred_svmfit5_comcov_rad = predict(svmfit5_comcov_rad, newdata = test5_comcov[,-1])

y_pred_svmfit1_comcov = predict(svmfit1_comcov, newdata = test1_comcov[,-1])
y_pred_svmfit1_comcov_rad = predict(svmfit1_comcov_rad, newdata = test1_comcov[,-1])

# Create confusion matrices
cmt5 = table(test5_comcov$status, y_pred_svmfit5_comcov)
cmt5_rad = table(test5_comcov$status, y_pred_svmfit5_comcov_rad)

cmt1 = table(test1_comcov$status, y_pred_svmfit1_comcov)
cmt1_rad = table(test1_comcov$status, y_pred_svmfit1_comcov_rad)

cm5_comcov = confusionMatrix(as.factor(test5_comcov$status), y_pred_svmfit5_comcov)
cm5_comcov_rad = confusionMatrix(as.factor(test5_comcov$status), y_pred_svmfit5_comcov_rad)

cm1_comcov = confusionMatrix(as.factor(test1_comcov$status), y_pred_svmfit1_comcov)
cm1_comcov_rad = confusionMatrix(as.factor(test1_comcov$status), y_pred_svmfit1_comcov_rad)


cat("\n1+ year linear model accuracy com + cov = ", round(cm1_comcov$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_comcov$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_comcov$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_comcov$overall["Accuracy"],4));

cat("\n1+ year radial model accuracy com + cov = ", round(cm1_comcov_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_comcov_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_comcov_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_comcov_rad$overall["Accuracy"],4));


cat("\n5+ year linear model accuracy com + cov = ", round(cm5_comcov$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_comcov$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_comcov$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_comcov$overall["Accuracy"],4));

cat("\n5+ year radial model accuracy com + cov = ", round(cm5_comcov_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_comcov_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_comcov_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_comcov_rad$overall["Accuracy"],4));


# ROC value
roc_svm5_comcov = roc(test5_comcov$status , as.numeric(y_pred_svmfit5_comcov), quiet=TRUE)
roc_svm5_comcov

roc_svm5_comcov_rad = roc(test5_comcov$status , as.numeric(y_pred_svmfit5_comcov_rad), quiet=TRUE)
roc_svm5_comcov_rad

roc_svm1_comcov = roc(test1_comcov$status , as.numeric(y_pred_svmfit1_comcov), quiet=TRUE)
roc_svm1_comcov

roc_svm1_comcov_rad = roc(test1_comcov$status , as.numeric(y_pred_svmfit1_comcov_rad), quiet=TRUE)
roc_svm1_comcov_rad
