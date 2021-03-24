rm(list=ls())
setwd("/rds/general/project/hda_students_data/live/General/")

library(data.table)

hes=data.frame(fread("hesin.txt", nrows=100))
# hes$epistart # start of episode date
episode_ID=paste0(hes$eid, "_", hes$ins_index)

hes_diag=data.frame(fread("hesin_diag.txt", nrows=100))
episode_ID_diag=paste0(hes_diag$eid, "_", hes_diag$ins_index)

