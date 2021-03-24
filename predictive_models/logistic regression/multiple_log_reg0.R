data<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data0_final.rds")


library(gplots)
library(caTools)
library(ROCR)

set.seed(31)

split = sample.split(data, SplitRatio = 0.8)
train = subset(data, split==TRUE)
test = subset(data, split==FALSE)

log_reg_pred = glm(status ~ .,  data = data, family=binomial)
summary(log_reg_pred)
predictTest = predict(log_reg_pred, type="response", newdata=test)
table(test$status, predictTest > 0.5)

ROCRpred = prediction(predictTest, test$status)
as.numeric(performance(ROCRpred, "auc")@y.values)

perf <- performance(ROCRpred,"tpr","fpr")

saveRDS(perf, "/rds/general/project/hda_students_data/live/Group7/General/Final/perf0.rds")
