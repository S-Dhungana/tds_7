# top comorbidities + covariates + biom 1 year prior


train_com<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train5.rds")
test_com<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test5.rds")

ICD10_1<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Logistic_reg/ICD10_5.rds")
new_train<- train_com[ ,which(colnames(train_com) %in% ICD10_1)]
new_train<-cbind(train_com['status'], new_train)

new_test<- test_com[ ,which(colnames(test_com) %in% ICD10_1)]
new_test<-cbind(test_com['status'], new_test)


train=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/train_all_covariates.rds")

test=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/test_all_covariates.rds")


rownames(biomarker_final)=biomarker_final$eid

new_test=new_test[which( rownames(new_test) %in% rownames(biomarker_final)),]
new_train=new_train[which( rownames(new_train)%in% rownames(biomarker_final)) ,]

test=test[which( rownames(test) %in% rownames(new_test)),]
train=train[which( rownames(train)%in% rownames(new_train)) ,]

train_biom= biomarker_final[which(rownames(biomarker_final) %in% rownames(new_train)),]
train_biom=train_biom[,2:29]

test_biom= biomarker_final[which( rownames(biomarker_final) %in%  rownames(new_test)),]
test_biom=test_biom[,2:29]

test=cbind(new_test,test, test_biom)
train=cbind(new_train,train,train_biom)


set.seed(31)

log_reg_pred = glm(status ~ .,  data = train, family=binomial)
summary(log_reg_pred)

predictTest = predict(log_reg_pred, type="response", newdata=test)
table(test$status, predictTest > 0.5)

ROCRpred = prediction(predictTest, test$status)
top_com_cov_auc_1=as.numeric(performance(ROCRpred, "auc")@y.values)
top_com_cov_auc_1

perf_com_cov_1 <- performance(ROCRpred,"tpr","fpr")
