rm(list=ls())
#Load data
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/data0_1.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_01.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_01.rds")


#####
rm(list=ls())

data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/data1_5.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_15.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_15.rds")


####
rm(list=ls())

data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/comorbidities_covariates_01.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcov_01.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcov_01.rds")

#####
rm(list=ls())
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/comorbidities_covariates_1_5.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcov_15.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcov_15.rds")

###
rm(list=ls())
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/comorbidities_covariates_biomarkers_01.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcovbio_1.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcovbio_1.rds")

####
rm(list=ls())

data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/comorbidities_covariates_biomarkers_1_5.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])
#eid as rowname
rownames(data) <- data[, "eid"]
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

data$eid=rownames(data)

#load packages
library(caTools)
#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]
#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcovbio_15.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcovbio_15.rds")