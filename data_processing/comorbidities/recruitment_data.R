test=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/comorbidity_no_meaning.rds")

epi_start_cases=test[which(test$diag_icd10 %in% skincancer),]
epi_start_cases$epistart=substring(epi_start_cases$epistart,7,10)      

epi_start_cases2= epi_start_cases %>% 
  distinct(eid, .keep_all = TRUE)

library(data.table)

data <- data.frame(fread("ukb26390.csv"))
eid <- data$eid 
recruitment <- data$X53.0.0

recruitment <- data.frame(eid,recruitment)
recruitment= recruitment[which(recruitment$eid %in% cases_eid),]
recruitment$recruitment=substring(recruitment$recruitment,1,4)                  
                   
final=merge(epi_start_cases2,recruitment) 

final_filter=final[which(final$recruitment<final$epistart),]
eid_cancer_post_enrollment=final_filter$eid
  
saveRDS(final_filter,"/rds/general/project/hda_students_data/live/Group7/General/Final/eids/enrolment_cancer_dates.rds")

saveRDS(eid_cancer_post_enrollment,"/rds/general/project/hda_students_data/live/Group7/General/Final/eids/eid_cancer_post_enrolment.rds")
