library(tidyverse)


comor=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/comorbidity_no_meaning.rds")

skincancer =c(c(paste0("C", 430:449)))
comor$diag_icd10<-as.character(comor$diag_icd10)

comor_filter<-comor[comor$diag_icd10 %in% skincancer,]
unique_cases<-unique(comor_filter$eid)

saveRDS(unique_cases,"/rds/general/project/hda_students_data/live/Group7/General/Final/CASES_eid.rds")

#install.packages('MatchIt')
library(MatchIt)

rownames(fcds)<- fcds$eid 
fcds$status<- 0

logical<-fcds$eid %in% unique_cases
fcds$status<-ifelse(logical==TRUE,1,0)


cases_controls_dataset<-matchit(status ~ age+ sex , data= fcds, method = "nearest", distance = "glm")
controls<-data.frame(cases_controls_dataset$match.matrix)

controls<-controls[,1]
cases<-unique_cases

### filtering from comorbidity no meaning
logical2<-comor$eid %in% cases
logical3<-comor$eid %in% controls
comor$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
comor$status<-ifelse(logical3==TRUE ,0,comor$status)


test<-which(!is.na(comor$status))
test2<-comor[test,]

controls_test=readRDS('/rds/general/project/hda_students_data/live/Group7/General/Final/MATCHIT.rds')
controls<-data.frame(controls_test$match.matrix)



saveRDS(fcds,"/rds/general/project/hda_students_data/live/Group7/General/Final/COVARIATES.rds")
saveRDS(cases_controls_dataset,"/rds/general/project/hda_students_data/live/Group7/General/Final/MATCHIT.rds")
saveRDS(cases,"/rds/general/project/hda_students_data/live/Group7/General/Final/cases_eid.rds")
saveRDS(controls,"/rds/general/project/hda_students_data/live/Group7/General/Final/controls_eid_2.rds")
saveRDS(test2,"/rds/general/project/hda_students_data/live/Group7/General/Final/cases_controls_hes.rds")
