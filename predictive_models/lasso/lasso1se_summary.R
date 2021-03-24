#table of comorbidities included in the Lasso

comor10 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected10.rds")
comor5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected5.rds")
comor3 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected3.rds")
comor1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected1.rds")
comor0 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selected0.rds")
comorcoc <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/comorbidities_selectedcoc.rds")

colnames(comor10) = c("ICD10", "10 years")
colnames(comor5) = c("ICD10", "5 years")
colnames(comor3) = c("ICD10", "3 years")
colnames(comor1) = c("ICD10", "1 years")
colnames(comor0) = c("ICD10", "0 years")
colnames(comorcoc) = c("ICD10", "co-occurent")

comorbidities <- merge(x = comor10, y = comor5,  by = "ICD10", all = TRUE)
comorbidities <- merge(x = comorbidities, y = comor3,  by = "ICD10", all = TRUE)
comorbidities <- merge(x = comorbidities, y = comor1,  by = "ICD10", all = TRUE)
comorbidities <- merge(x = comorbidities, y = comor0,  by = "ICD10", all = TRUE)
comorbidities <- merge(x = comorbidities, y = comorcoc,  by = "ICD10", all = TRUE)

#table of AUCs
auc10 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc10.rds")
auc5 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc5.rds")
auc3 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc3.rds")
auc1 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc1.rds")
auc0 <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auc0.rds")
auccoc <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/auccoc.rds")

auc <- data.frame("10 years" = auc10, "5 years" =auc5, "3 years" =auc3, "1 years" =auc1, "0 years" =auc0, "co-occurent" =auccoc)







