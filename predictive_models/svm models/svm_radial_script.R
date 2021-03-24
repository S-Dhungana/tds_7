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

train5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm.rds")
test5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm.rds")

train1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm.rds")
test1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm.rds")


## SVM 5 year algorithm
svmfit5_rad = svm(formula = status ~ ., data = train5, type = 'C-classification', kernel = 'radial')
svmfit5_rad

## Export svm file 
save(svmfit5_rad, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm5fit_rad.rda")

## SVM 1 year algorithm
svmfit1_rad = svm(formula = status ~ ., data = train1, type = 'C-classification', kernel = 'radial')
svmfit1_rad

## Export svm file 
save(svmfit1_rad, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svm1fit_rad.rda")
