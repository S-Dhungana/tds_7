data<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/new_1.rds")

log_reg_pred = glm(status ~ .,  data = data, family=binomial)

saveRDS(log_reg_pred , "/rds/general/project/hda_students_data/live/Group7/General/Final/res1_2.rds")