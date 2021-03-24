
library(dplyr)

filter_incident_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")

train<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_comcovbio_1.rds")
train=train[which(rownames(train)  %in% filter_incident_cases),]
train=select(train, -eid)

test<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_comcovbio_1.rds")
test=test[which(rownames(test)  %in% filter_incident_cases),]
test=select(test, -eid)

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

saveRDS(log_reg_pred , "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/trainbiom1_mr.rds")
saveRDS(perf, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/testbiom1.rds")