check0=data.frame(CopyOfdata0)
logical2<-rownames(check0) %in% cases_eid
logical3<-rownames(check0) %in% controls_eid
check0$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
check0$status<-ifelse(logical3==TRUE ,0,check0$status)

saveRDS(check0, "/rds/general/project/hda_students_data/live/Group7/General/Final/new0.rds")

new_co_occurrent<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/CopyOfdata_cooccurent.rds"))

logical2<-rownames(new_co_occurrent) %in% cases_eid
logical3<-rownames(new_co_occurrent) %in% controls_eid
new_co_occurrent$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
new_co_occurrent$status<-ifelse(logical3==TRUE ,0,new_co_occurrent$status)
saveRDS(new_co_occurrent, "/rds/general/project/hda_students_data/live/Group7/General/Final/new_coc.rds")

new_10<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/CopyOfdata10.rds"))

logical2<-rownames(new_10) %in% cases_eid
logical3<-rownames(new_10) %in% controls_eid
new_10$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
new_10$status<-ifelse(logical3==TRUE ,0,new_10$status)
saveRDS(new_10, "/rds/general/project/hda_students_data/live/Group7/General/Final/new_10.rds")

new_5<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/CopyOfdata5.rds"))

logical2<-rownames(new_5) %in% cases_eid
logical3<-rownames(new_5) %in% controls_eid
new_5$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
new_5$status<-ifelse(logical3==TRUE ,0,new_5$status)
saveRDS(new_5, "/rds/general/project/hda_students_data/live/Group7/General/Final/new_5.rds")



new_3<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/CopyOfdata3.rds"))

logical2<-rownames(new_3) %in% cases_eid
logical3<-rownames(new_3) %in% controls_eid
new_3$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
new_3$status<-ifelse(logical3==TRUE ,0,new_3$status)
saveRDS(new_3, "/rds/general/project/hda_students_data/live/Group7/General/Final/new_3.rds")

new_1<- data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/CopyOfdata1.rds"))


logical2<-rownames(new_1) %in% cases_eid
logical3<-rownames(new_1) %in% controls_eid
new_1$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
new_1$status<-ifelse(logical3==TRUE ,0,new_1$status)
saveRDS(new_1, "/rds/general/project/hda_students_data/live/Group7/General/Final/new_1.rds")
