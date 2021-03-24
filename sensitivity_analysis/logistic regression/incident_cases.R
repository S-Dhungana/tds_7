
data1<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/new_1.rds"))
filter_incident_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")
data1=data1[which(rownames(data1) %in% filter_incident_cases),]

data5<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/new_5.rds"))
data5=data1[which(rownames(data5) %in% filter_incident_cases),]

foo_00 = function(X) {
  model0 = glm(status ~ X, data = data1)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results_1 = data.frame(apply(data1[,2:8138], 2, FUN = foo_00))
colnames(results_1)='pval'
saveRDS(results_1, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/results_1.rds")




foo_0 = function(X) {
  model0 = glm(status ~ X, data = data5)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}
results_5 = data.frame(apply(data5[,2:8138], 2, FUN = foo_0))
colnames(results_5)='pval'
saveRDS(results_5, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/results_5.rds")


