controls= readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/controls_eid.rds")
cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/cases_eid.rds")

logical2<-hes_comorbidities_final$eid %in% cases
logical3<-hes_comorbidities_final$eid %in% controls
hes_comorbidities_final$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
hes_comorbidities_final$status<-ifelse(logical3==TRUE ,0,hes_comorbidities_final$status)

library(dplyr)
hes_comorbidities_final<-hes_comorbidities_final %>%
  select('status', everything())


hes_comorbidities_final['sumrow',]<-colSums(hes_comorbidities_final)

hes_comorbidities_final[,'sumcol']<-rowsum(hes_comorbidities_final)


hes_comorbidities_final['sum',]<-colsum(hes_comorbidities_final)