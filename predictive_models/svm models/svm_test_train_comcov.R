library(tidyverse)
library(caTools)
library(pROC)

train5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm.rds")
test5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm.rds")

train1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm.rds")
test1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm.rds")

cov_hot_enc <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/covariates_hot_encoded.rds")

train5$eid <- rownames(train5)
class(train5$eid)
cov_hot_enc$eid <- as.character(cov_hot_enc$eid)
train5_comcov <- left_join(train5, cov_hot_enc, by = c("eid"))
rownames(train5_comcov) <- train5_comcov$eid
rownames(train5_comcov)
train5_comcov

test5$eid <- rownames(test5)
class(test5$eid)
cov_hot_enc$eid <- as.character(cov_hot_enc$eid)
test5_comcov <- left_join(test5, cov_hot_enc, by = c("eid"))
rownames(test5_comcov) <- test5_comcov$eid
rownames(test5_comcov)
test5_comcov

train1$eid <- rownames(train1)
class(train1$eid)
cov_hot_enc$eid <- as.character(cov_hot_enc$eid)
train1_comcov <- left_join(train1, cov_hot_enc, by = c("eid"))
rownames(train1_comcov) <- train1_comcov$eid
rownames(train1_comcov)
train1_comcov

test1$eid <- rownames(test1)
class(test1$eid)
cov_hot_enc$eid <- as.character(cov_hot_enc$eid)
test1_comcov <- left_join(test1, cov_hot_enc, by = c("eid"))
rownames(test1_comcov) <- test1_comcov$eid
rownames(test1_comcov)
test1_comcov

saveRDS(train5_comcov,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train5_svm_comcov.rds")
saveRDS(test5_comcov,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test5_svm_comcov.rds")
saveRDS(train1_comcov,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/train1_svm_comcov.rds")
saveRDS(test1_comcov,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/test1_svm_comcov.rds")

