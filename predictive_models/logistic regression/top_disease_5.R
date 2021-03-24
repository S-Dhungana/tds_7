library(tidyverse)


train<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train5.rds")
test<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test5.rds")

ICD10_5<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/ICD10_5.rds")
new_train<- train[ ,which(colnames(train) %in% ICD10_5)]
new_train<-cbind(train['status'], new_train)

new_test<- test[ ,which(colnames(test) %in% ICD10_5)]
new_test<-cbind(test['status'], new_test)

library(gplots)
library(caTools)
library(ROCR)

set.seed(31)

log_reg_pred = glm(status ~ .,  data = new_train, family=binomial)
summary(log_reg_pred)

predictTest = predict(log_reg_pred, type="response", newdata=new_test)
table(new_test$status, predictTest > 0.5)

ROCRpred = prediction(predictTest, new_test$status)
as.numeric(performance(ROCRpred, "auc")@y.values)

perf <- performance(ROCRpred,"tpr","fpr")

saveRDS(log_reg_pred , "/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/top_train5_mr.rds")
saveRDS(perf, "/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/top_test_5_mr.rds")



