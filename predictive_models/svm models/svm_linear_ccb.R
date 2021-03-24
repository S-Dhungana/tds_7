library(e1071)
library(caret)
library(dplyr)
library(tidyverse)
library(caTools)
library(pROC)

train5_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_ccb.rds")
test5_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_ccb.rds")

train1_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_ccb.rds")
test1_ccb <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_ccb.rds")

train5_ccb <- subset(train5_ccb, select = -eid)
test5_ccb <- subset(test5_ccb, select = -eid)
train1_ccb <- subset(train1_ccb, select = -eid)
test1_ccb <- subset(test1_ccb, select = -eid)

## SVM 5 year algorithm
svmfit5_ccb = svm(formula = status ~ ., data = train5_ccb, type = 'C-classification', kernel = 'linear')
svmfit5_ccb

save(svmfit5_ccb, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_ccb.rda")

## SVM 1 year algorithm
svmfit1_ccb = svm(formula = status ~ ., data = train1_ccb, type = 'C-classification', kernel = 'linear')
svmfit1_ccb

save(svmfit1_ccb, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_ccb.rda")