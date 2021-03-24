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


svmfit_win_1 = svm(formula = status ~ ., data = train_win_1, type = 'C-classification', kernel = 'radial')
svmfit_win_1

save(svmfit_win_1, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_1.rda")

svmfit_win_5 = svm(formula = status ~ ., data = train_win_5, type = 'C-classification', kernel = 'radial')
svmfit_win_5

save(svmfit_win_5, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_5.rda")

svmfit_win_comcov_1 = svm(formula = status ~ ., data = train_win_comcov_1, type = 'C-classification', kernel = 'radial')
svmfit_win_comcov_1

save(svmfit_win_comcov_1, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_comcov_1.rda")

svmfit_win_comcov_5 = svm(formula = status ~ ., data = train_win_comcov_5, type = 'C-classification', kernel = 'radial')
svmfit_win_comcov_5

save(svmfit_win_comcov_5, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_comcov_5.rda")

svmfit_win_ccb_1 = svm(formula = status ~ ., data = train_win_ccb_1, type = 'C-classification', kernel = 'radial')
svmfit_win_ccb_1

save(svmfit_win_ccb_1, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_ccb_1.rda")

svmfit_win_ccb_5 = svm(formula = status ~ ., data = train_win_ccb_5, type = 'C-classification', kernel = 'radial')
svmfit_win_ccb_5

save(svmfit_win_ccb_5, file = "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/svmfit_win_ccb_5.rda")
