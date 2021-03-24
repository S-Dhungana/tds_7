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

train5_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_ccb.rds")
test5_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_ccb.rds")
train1_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm_ccb.rds")
test1_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm_ccb.rds")


load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_ccb.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_ccb.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_ccb_rad.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_ccb_rad.rda")

# Predict fit on test
y_pred_svmfit5_ccb = predict(svmfit5_ccb, newdata = test5_ccb[,-1])
y_pred_svmfit5_ccb_rad = predict(svmfit5_ccb_rad, newdata = test5_ccb[,-1])

y_pred_svmfit1_ccb = predict(svmfit1_ccb, newdata = test1_ccb[,-1])
y_pred_svmfit1_ccb_rad = predict(svmfit1_ccb_rad, newdata = test1_ccb[,-1])

# Create confusion matrices
cmt5 = table(test5_ccb$status, y_pred_svmfit5_ccb)
cmt5_rad = table(test5_ccb$status, y_pred_svmfit5_ccb_rad)

cmt1 = table(test1_ccb$status, y_pred_svmfit1_ccb)
cmt1_rad = table(test1_ccb$status, y_pred_svmfit1_ccb_rad)

cm5_ccb = confusionMatrix(as.factor(test5_ccb$status), y_pred_svmfit5_ccb)
cm5_ccb_rad = confusionMatrix(as.factor(test5_ccb$status), y_pred_svmfit5_ccb_rad)

cm1_ccb = confusionMatrix(as.factor(test1_ccb$status), y_pred_svmfit1_ccb)
cm1_ccb_rad = confusionMatrix(as.factor(test1_ccb$status), y_pred_svmfit1_ccb_rad)


cat("\n1+ year linear model accuracy all = ", round(cm1_ccb$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_ccb$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_ccb$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_ccb$overall["Accuracy"],4));

cat("\n1+ year radial model accuracy all = ", round(cm1_ccb_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_ccb_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_ccb_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_ccb_rad$overall["Accuracy"],4));


cat("\n5+ year linear model accuracy all = ", round(cm5_comcov$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_ccb$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_ccb$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_ccb$overall["Accuracy"],4));

cat("\n5+ year radial model accuracy all = ", round(cm5_comcov_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_ccb_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_ccb_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_ccb_rad$overall["Accuracy"],4));


# ROC value
roc_svm5_ccb = roc(test5_ccb$status , as.numeric(y_pred_svmfit5_ccb), quiet=TRUE)
roc_svm5_ccb

roc_svm5_ccb_rad = roc(test5_ccb$status , as.numeric(y_pred_svmfit5_ccb_rad), quiet=TRUE)
roc_svm5_ccb_rad

roc_svm1_ccb = roc(test1_ccb$status , as.numeric(y_pred_svmfit1_ccb), quiet=TRUE)
roc_svm1_ccb

roc_svm1_ccb_rad = roc(test1_ccb$status , as.numeric(y_pred_svmfit1_ccb_rad), quiet=TRUE)
roc_svm1_ccb_rad
