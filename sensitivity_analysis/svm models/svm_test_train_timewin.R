library(e1071)
library(caret)
library(dplyr)
library(tidyverse)
library(caTools)
library(pROC)

train_window_01 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_01.rds")
test_window_01 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_01.rds")

train_window_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_15.rds")
test_window_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_15.rds")

train_window_comcov_01 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcov_01.rds")
test_window_comcov_01 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcov_01.rds")

train_window_comcov_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcov_15.rds")
test_window_comcov_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcov_15.rds")

train_window_comcovbio_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcovbio_1.rds")
test_window_comcovbio_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcovbio_1.rds")

train_window_comcovbio_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcovbio_15.rds")
test_window_comcovbio_15 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcovbio_15.rds")

significant_ICD_1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/significant_ICD_1.rds")
significant_ICD_5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/significant_ICD_5.rds")

###############################################################################################################################

significant_ICD_1 <- c(significant_ICD_1, 'status')
significant_ICD_5 <- c(significant_ICD_5, 'status')

train_win_1 <- train_window_01[, colnames(train_window_01) %in% significant_ICD_1]
test_win_1 <- test_window_01[, colnames(test_window_01) %in% significant_ICD_1]

train_win_5 <- train_window_15[, colnames(train_window_15) %in% significant_ICD_5]
test_win_5 <- test_window_15[, colnames(test_window_15) %in% significant_ICD_5]

###############################################################################################################################
cov_hot_enc <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/covariates_hot_encoded.rds")

cov_colnames <- colnames(cov_hot_enc)
sig_ICD_1_comcov <- c(significant_ICD_1, cov_colnames)
sig_ICD_5_comcov <- c(significant_ICD_5, cov_colnames)

train_win_comcov_1 <- train_window_comcov_01[, colnames(train_window_comcov_01) %in% sig_ICD_1_comcov]
test_win_comcov_1 <- test_window_comcov_01[, colnames(test_window_comcov_01) %in% sig_ICD_1_comcov]

train_win_comcov_5 <- train_window_comcov_15[, colnames(train_window_comcov_15) %in% sig_ICD_5_comcov]
test_win_comcov_5 <- test_window_comcov_15[, colnames(test_window_comcov_15) %in% sig_ICD_5_comcov]

train_win_comcov_1 <- subset(train_win_comcov_1, select = -eid)
test_win_comcov_1 <- subset(test_win_comcov_1, select = -eid)

train_win_comcov_5 <- subset(train_win_comcov_5, select = -eid)
test_win_comcov_5 <- subset(test_win_comcov_5, select = -eid)

############################################################################################################################
biomarker_final <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_final.rds")

bio_colnames <- colnames(biomarker_final)
sig_ICD_1_ccb <- c(sig_ICD_1_comcov, bio_colnames)
sig_ICD_5_ccb <- c(sig_ICD_5_comcov, bio_colnames)

train_win_ccb_1 <- train_window_comcovbio_1[, colnames(train_window_comcovbio_1) %in% sig_ICD_1_ccb] 
test_win_ccb_1 <- test_window_comcovbio_1[, colnames(test_window_comcovbio_1) %in% sig_ICD_1_ccb] 

train_win_ccb_5 <- train_window_comcovbio_15[, colnames(train_window_comcovbio_15) %in% sig_ICD_5_ccb] 
test_win_ccb_5 <- test_window_comcovbio_15[, colnames(test_window_comcovbio_15) %in% sig_ICD_5_ccb] 

train_win_ccb_1 <- subset(train_win_ccb_1, select = -eid)
test_win_ccb_1 <- subset(test_win_ccb_1, select = -eid)

train_win_ccb_5 <- subset(train_win_ccb_5, select = -eid)
test_win_ccb_5 <- subset(test_win_ccb_5, select = -eid)

############################################################################################################################

saveRDS(train_win_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_1.rds")
saveRDS(test_win_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_1.rds")

saveRDS(train_win_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_5.rds")
saveRDS(test_win_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_5.rds")


saveRDS(train_win_comcov_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_comcov_1.rds")
saveRDS(test_win_comcov_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_comcov_1.rds")

saveRDS(train_win_comcov_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_comcov_5.rds")
saveRDS(test_win_comcov_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_comcov_5.rds")


saveRDS(train_win_ccb_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_ccb_1.rds")
saveRDS(test_win_ccb_1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_ccb_1.rds")

saveRDS(train_win_ccb_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train_win_ccb_5.rds")
saveRDS(test_win_ccb_5,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test_win_ccb_5.rds")


