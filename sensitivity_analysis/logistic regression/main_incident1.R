
incident_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")

train<-readRDS('/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_covariates_bio_train1.rds')

train=train[which(rownames(train) %in% incident_cases),]

test<-readRDS('/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_bio_covariates_test1.rds')
test=test[which(rownames(test) %in% incident_cases),]

library(gplots)
library(caTools)
library(ROCR)

set.seed(31)

log_reg_pred = glm(status ~ .,  data = train, family=binomial)
summary(log_reg_pred)

predictTest = predict(log_reg_pred, type="response", newdata=test)
table(test$status, predictTest > 0.5)

ROCRpred = prediction(predictTest, test$status)
as.numeric(performance(ROCRpred, "auc")@y.values)

perf <- performance(ROCRpred,"tpr","fpr")

saveRDS(log_reg_pred , "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/biom1_mr_main.rds")
saveRDS(perf, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/testbiom1_mr_main.rds")