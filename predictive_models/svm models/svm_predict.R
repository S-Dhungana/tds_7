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

test1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm.rds")
train1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm.rds")
test5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm.rds")
train5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm.rds")

load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_rad.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_sig.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_rad.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_sig.rda")

# Predict fit on test
y_pred_svmfit5 = predict(svmfit5, newdata = test5[,-1])
y_pred_svmfit5_rad = predict(svmfit5_rad, newdata = test5[,-1])
y_pred_svmfit5_sig = predict(svmfit5_sig, newdata = test5[,-1])

y_pred_svmfit1 = predict(svmfit1, newdata = test1[,-1])
y_pred_svmfit1_rad = predict(svmfit1_rad, newdata = test1[,-1])
y_pred_svmfit1_sig = predict(svmfit1_sig, newdata = test1[,-1])

# Create confusion matrices
cmt5 = table(test5$status, y_pred_svmfit5)
cmt5_rad = table(test5$status, y_pred_svmfit5_rad)
cmt5_sig = table(test5$status, y_pred_svmfit5_sig)

cmt1 = table(test1$status, y_pred_svmfit1)
cmt1_rad = table(test1$status, y_pred_svmfit1_rad)
cmt1_sig = table(test1$status, y_pred_svmfit1_sig)

cm5 = confusionMatrix(as.factor(test5$status), y_pred_svmfit5)
cm5_rad = confusionMatrix(as.factor(test5$status), y_pred_svmfit5_rad)
cm5_sig = confusionMatrix(as.factor(test5$status), y_pred_svmfit5_sig)

cm1 = confusionMatrix(as.factor(test1$status), y_pred_svmfit1)
cm1_rad = confusionMatrix(as.factor(test1$status), y_pred_svmfit1_rad)
cm1_sig = confusionMatrix(as.factor(test1$status), y_pred_svmfit1_sig)


cat("\n1+ year linear model accuracy = ", round(cm1$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1$overall["Accuracy"],4));

cat("\n1+ year radial model accuracy = ", round(cm1_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_rad$overall["Accuracy"],4));

cat("\n1+ year sigmoid model accuracy = ", round(cm1_sig$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm1_sig$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm1_sig$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm1_sig$overall["Accuracy"],4));

cat("\n5+ year linear model accuracy = ", round(cm5$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5$overall["Accuracy"],4));

cat("\n5+ year radial model accuracy = ", round(cm5_rad$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_rad$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_rad$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_rad$overall["Accuracy"],4));

cat("\n5+ year sigmoid model accuracy = ", round(cm5_sig$overall["Accuracy"],4), 
    "Sensitivity =",  round(cm5_sig$byClass["Sensitivity"],4), 
    "Specificity = ", round(cm5_sig$byClass["Specificity"], 4), 
    "error rate = ",1 - round(cm5_sig$overall["Accuracy"],4));

# ROC value
roc_svm5 = roc(test5$status , as.numeric(y_pred_svmfit5), quiet=TRUE)
roc_svm5
roc_svm5_rad = roc(test5$status , as.numeric(y_pred_svmfit5_rad), quiet=TRUE)
roc_svm5_rad
roc_svm5_sig = roc(test5$status , as.numeric(y_pred_svmfit5_sig), quiet=TRUE)
roc_svm5_sig

roc_svm1 = roc(test1$status , as.numeric(y_pred_svmfit1), quiet=TRUE)
roc_svm1
roc_svm1_rad = roc(test1$status , as.numeric(y_pred_svmfit1_rad), quiet=TRUE)
roc_svm1_rad
roc_svm1_sig = roc(test1$status , as.numeric(y_pred_svmfit1_sig), quiet=TRUE)
roc_svm1_sig
