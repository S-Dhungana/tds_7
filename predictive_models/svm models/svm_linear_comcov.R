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

train1_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_comcov.rds")
test1_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_comcov.rds")

train5_comcov <- subset(train5_comcov, select = -eid)
test5_comcov <- subset(test5_comcov, select = -eid)
train1_comcov <- subset(train1_comcov, select = -eid)
test1_comcov <- subset(test1_comcov, select = -eid)

## SVM 5 year algorithm
svmfit5_comcov = svm(formula = status ~ ., data = train5_comcov, type = 'C-classification', kernel = 'linear')
svmfit5_comcov

save(svmfit5_comcov, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_comcov.rda")

## SVM 1 year algorithm
svmfit1_comcov = svm(formula = status ~ ., data = train1_comcov, type = 'C-classification', kernel = 'linear')
svmfit1_comcov

save(svmfit1_comcov, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_comcov.rda")
