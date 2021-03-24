
#top como + biom +cov 


train_com<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/train_window_01.rds")
test_com<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/test_window_01.rds")

filter_incident_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")

ICD10_5<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/significant_ICD_1.rds")
new_train<- train_com[ ,which(colnames(train_com) %in% ICD10_5)]
new_train<-cbind(train_com['status'], new_train)

new_test<- test_com[ ,which(colnames(test_com) %in% ICD10_5)]
new_test<-cbind(test_com['status'], new_test)


train=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train_all_covariates.rds")
test=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test_all_covariates.rds")


rownames(biomarker_final)=biomarker_final$eid

new_test=new_test[which( rownames(new_test) %in% rownames(biomarker_final)),]
new_train=new_train[which( rownames(new_train)%in% rownames(biomarker_final)) ,]

test=test[which( rownames(test) %in% rownames(biomarker_final)),]
train=train[which( rownames(train)%in% rownames(biomarker_final)) ,]

train_biom= biomarker_final[which(rownames(biomarker_final) %in% rownames(new_train)),]
train_biom=train_biom[,2:29]

test_biom= biomarker_final[which( rownames(biomarker_final) %in%  rownames(new_test)),]
test_biom=test_biom[,2:29]

test2=cbind(new_test,test, test_biom)
train2=cbind(new_train,train,train_biom)


train3=train2[which(rownames(train2) %in% filter_incident_cases),]
test3=test2[which(rownames(test2) %in% filter_incident_cases),]

train=train3
test=test3

set.seed(31)

log_reg_pred = glm(status ~ .,  data = train, family=binomial)
summary(log_reg_pred)

predictTest = predict(log_reg_pred, type="response", newdata=test)
table(test$status, predictTest > 0.5)

ROCRpred = prediction(predictTest, test$status)
top_com_cov_auc_5=as.numeric(performance(ROCRpred, "auc")@y.values)
top_com_cov_auc_5

perf_com_cov_5 <- performance(ROCRpred,"tpr","fpr")


```