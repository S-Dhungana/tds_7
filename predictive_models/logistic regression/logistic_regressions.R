data_cooccurent<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data_cooccurent_final.rds"))
data0<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data0_final.rds"))
data1<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data1_final.rds"))
data3<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data3_final.rds"))
data5<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data5_final.rds"))
data10<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data10_final.rds"))


foo_00 = function(X) {
  model0 = glm(status ~ X, data = data_cooccurent)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results_coc = data.frame(apply(data_cooccurent[,2:8138], 2, FUN = foo_00))
colnames(results_coc)='pval'
saveRDS(data10, "/rds/general/project/hda_students_data/live/Group7/General/Final/results_coc.rds")




foo_0 = function(X) {
  model0 = glm(status ~ X, data = data0)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}
results0 = data.frame(apply(data0[,2:8138], 2, FUN = foo_0))
colnames(results0)='pval'
saveRDS(results0, "/rds/general/project/hda_students_data/live/Group7/General/Final/results0.rds")

foo_1 = function(X) {
  model0 = glm(status ~ X, data = data1)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results1 = data.frame(apply(data1[,2:8138], 2, FUN = foo_1))
colnames(results1)='pval'
saveRDS(results1, "/rds/general/project/hda_students_data/live/Group7/General/Final/results1.rds")

foo_3 = function(X) {
  model0 = glm(status ~ X, data = data3)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results3 = data.frame(apply(data3[,2:8138], 2, FUN = foo_3))
colnames(results3)='pval'
saveRDS(results3, "/rds/general/project/hda_students_data/live/Group7/General/Final/results3.rds")

foo_5 = function(X) {
  model0 = glm(status ~ X, data = data5)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results5 = data.frame(apply(data5[,2:8138], 2, FUN = foo_5))
colnames(results5)='pval'
saveRDS(results5, "/rds/general/project/hda_students_data/live/Group7/General/Final/results5.rds")

foo_10 = function(X) {
  model0 = glm(status ~ X, data = data10)
  #results = c(exp(coef(model0)[2]),coef(summary(model0))[,'Pr(>|z|)'][2])
  #names(results) = c("coef", "pval")
  results=coef(summary(model0))[,4][2]
  #names(results)='pval'
  return(results)
}

results10 = data.frame(apply(data10[,2:8138], 2, FUN = foo_10))
colnames(results10)='pval'

saveRDS(results10, "/rds/general/project/hda_students_data/live/Group7/General/Final/results10.rds")

