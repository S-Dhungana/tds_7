rm(list=ls())

library('data.table')
library('ukbtools')

setwd("/rds/general/project/hda_students_data/live/General/")

hes=data.frame(fread("hesin.txt"))
# hes$epistart # start of episode date
episode_ID=paste0(hes$eid, "_", hes$ins_index)

hes_diag=data.frame(fread("hesin_diag.txt"))
episode_ID_diag=paste0(hes_diag$eid, "_", hes_diag$ins_index)


hes_diag2<-merge(x = hes_diag, y = hes, by = c("eid", 'ins_index'), all.x=TRUE )
hes_diag2bis<-hes_diag2[,1:12]
hes_comor<-hes_diag2bis[,c('eid','diag_icd9','diag_icd10','epistart')]
hes_comor$diag_icd9<-as.character(hes_comor$diag_icd9)

hes_comor$diag_icd10[which(hes_comor$diag_icd10 == 'Y1109')] <- ""

hes_comor$diag_icd10[which(hes_comor$diag_icd10 == "")] <- NA
hes_comor$diag_icd9[which(hes_comor$diag_icd9 == "")] <- NA

hes_comor$meaning10_n<-data.frame(t(sapply(hes_comor$diag_icd10, FUN=ukb_icd_code_meaning)))$meaning
hes_comor$meaning9_n<-data.frame(t(sapply(hes_comor$diag_icd9, FUN=ukb_icd_code_meaning(icd.version=9))))$meaning

#save data set
saveRDS(hes_comor,"/rds/general/project/hda_students_data/live/Group7/General/Eleonore/comorbidity_with_meaning.rds")
saveRDS(fcds,"/rds/general/project/hda_students_data/live/Group7/General/Eleonore/comorbidity_with_meaning.rds")
