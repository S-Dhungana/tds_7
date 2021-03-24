library(e1071)
library(caret)
library(dplyr)
library(tidyverse)
library(caTools)
library(pROC)

train_win_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_1.rds")
test_win_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_1.rds")

train_win_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_5.rds")
test_win_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_5.rds")

train_win_comcov_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_comcov_1.rds")
test_win_comcov_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_comcov_1.rds")

train_win_comcov_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_comcov_5.rds")
test_win_comcov_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_comcov_5.rds")

train_win_ccb_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_ccb_1.rds")
test_win_ccb_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_ccb_1.rds")

train_win_ccb_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_ccb_5.rds")
test_win_ccb_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_ccb_5.rds")


load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_1.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_5.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_comcov_1.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_comcov_5.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_ccb_1.rda")
load("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_ccb_5.rda")

# Predict fit on test
y_pred_svmfit_win_1 = predict(svmfit_win_1, newdata = test_win_1[,-1])
y_pred_svmfit_win_5 = predict(svmfit_win_5, newdata = test_win_5[,-1])

y_pred_svmfit_win_comcov_1 = predict(svmfit_win_comcov_1, newdata = test_win_comcov_1[,-1])
y_pred_svmfit_win_comcov_5 = predict(svmfit_win_comcov_5, newdata = test_win_comcov_5[,-1])

y_pred_svmfit_win_ccb_1 = predict(svmfit_win_ccb_1, newdata = test_win_ccb_1[,-1])
y_pred_svmfit_win_ccb_5 = predict(svmfit_win_ccb_1, newdata = test_win_ccb_1[,-1])

# ROC value
roc_svm_win_1 = roc(test_win_1$status , as.numeric(y_pred_svmfit_win_1), quiet=TRUE)
roc_svm_win_1

roc_svm_win_5 = roc(test_win_5$status , as.numeric(y_pred_svmfit_win_5), quiet=TRUE)
roc_svm_win_5

roc_svm_win_comcov_1 = roc(test_win_comcov_1$status , as.numeric(y_pred_svmfit_win_comcov_1), quiet=TRUE)
roc_svm_win_comcov_1

roc_svm_win_comcov_5 = roc(test_win_comcov_5$status , as.numeric(y_pred_svmfit_win_comcov_5), quiet=TRUE)
roc_svm_win_comcov_5

roc_svm_win_ccb_1 = roc(test_win_ccb_1$status , as.numeric(y_pred_svmfit_win_ccb_1), quiet=TRUE)
roc_svm_win_ccb_1

roc_svm_win_ccb_5 = roc(test_win_ccb_5$status , as.numeric(y_pred_svmfit_win_ccb_5), quiet=TRUE)
roc_svm_win_ccb_5


