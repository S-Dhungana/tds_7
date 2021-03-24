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

# 5 years and above
## Read in data
table_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/Univariate/table_5.rds")

## Extract list of features that are shown to be significant 
table_5
table_5<- as.data.frame(table_5)
table_5 <- c(Filter(Negate(is.null),lapply(table_5,levels)))
table_5$ICD10_5
ICD10_5 <- sub(" .+", "", table_5$ICD10_5)  %>% str_replace_all('\\.', '')
ICD10_5 <- c(ICD10_5, 'status')
ICD10_5

## Filter features that are only part of the significant vector
test5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test5.rds")
train5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train5.rds")

train5 <- train5[, colnames(train5) %in% ICD10_5]
test5 <- test5[, colnames(test5) %in% ICD10_5]

names(train5)
names(test5)

## SVM training and test datasets
saveRDS(train5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm.rds")
saveRDS(test5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm.rds")

###################################################################################################################

# 1 year 
## Read in data
table_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/Univariate/table_1.rds")

## Extract list of features that are shown to be significant 
table_1
table_1<- as.data.frame(table_1)
table_1 <- c(Filter(Negate(is.null),lapply(table_1,levels)))
table_1$ICD10_1
ICD10_1 <- sub(" .+", "", table_1$ICD10_1)  %>% str_replace_all('\\.', '')
ICD10_1 <- c(ICD10_1, 'status')
ICD10_1

## Filter features that are only part of the significant vector
test1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test1.rds")
train1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train1.rds")

train1 <- train1[, colnames(train1) %in% ICD10_1]
test1 <- test1[, colnames(test1) %in% ICD10_1]

names(train1)
names(test1)

## SVM training and test datasets
saveRDS(train1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm.rds")
saveRDS(test1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm.rds")

