train5_full<- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_covariates_bio_train5.rds")
train1_full<- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_covariates_bio_train1.rds")

test5_full <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_bio_covariates_test5.rds")
test1_full <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_bio_covariates_test1.rds")

train5_comcov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_comcov.rds")
biomarker_final <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_final.rds")

filter_incident_cases <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")

cols <- colnames(train5_comcov)
cols <- c(cols, colnames(biomarker_final))
length(cols)

train5_full <- train5_full[, colnames(train5_full) %in% cols]
test5_full <- test5_full[, colnames(test5_full) %in% cols]
train1_full <- train1_full[, colnames(train1_full) %in% cols]
test1_full <- test1_full[, colnames(test1_full) %in% cols]

train5_full$eid <- rownames(train5_full)
class(train5_full$eid)

train1_full$eid <- rownames(train1_full)
class(train1_full$eid)

test5_full$eid <- rownames(test5_full)
class(test5_full$eid)

test1_full$eid <- rownames(test1_full)
class(test1_full$eid)

train5_ccb <- train5_full[which(train5_full$eid %in% filter_incident_cases),]
train1_ccb <- train1_full[which(train1_full$eid %in% filter_incident_cases),]

test5_ccb <- test5_full[which(test5_full$eid %in% filter_incident_cases),]
test1_ccb <- test1_full[which(test1_full$eid %in% filter_incident_cases),]

saveRDS(train5_ccb,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_ccb.rds")
saveRDS(test5_ccb,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_ccb.rds")
saveRDS(train1_ccb,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm_ccb.rds")
saveRDS(test1_ccb,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm_ccb.rds")

