# remove columns with skin or melanoma diagnosis

vector_date_case= readRDS("/rds/general/project/hda_students_data/live/Group7/General/Carolina/cases_date_extraction.rds")


saveRDS(vector_date_case, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector_date_case.rds")

vector=vector_date_case$skincancer_diagnosis_date
vector2=vector_date_case$skincancer_diagnosis_date[which(logcon==1)]

vector_test=vector_date_case$skincancer_diagnosis_date[which(log==1)]
vector==vector_test
eid_final=rownames(diag_date_recode_ca)


saveRDS(vector, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector.rds")
saveRDS(vector2, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector2.rds")

dates_df=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_final_onlydates.rds")


skincancer= c(c(paste0("C",430:449, "_date")))
dates_df_noskincancer=dates_df %>%
  select(-contains(skincancer))


logical2<-rownames(dates_df_noskincancer) %in% cases_eid2
logical3<-rownames(dates_df_noskincancer) %in% controls_eid2
dates_df_noskincancer$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
dates_df_noskincancer$status<-ifelse(logical3==TRUE ,0,dates_df_noskincancer$status)

dates_df_noskincancer_cases2=dates_df_noskincancer[which(dates_df_noskincancer$status==1),]

dates_df_noskincancer_controls=dates_df_noskincancer[which(dates_df_noskincancer$status==0),]

logcon= rownames(dates_df_noskincancer_controls) %in% controls_eid

log=  vector_date_case$eid %in% cases_eid
controls_eid2= controls_eid[which(log==1)]
vector_date_case$controls=controls_eid2
cases_eid2=cases_eid[which(log==1)]

dates_df_noskincancer_cases2=dates_df_noskincancer_cases[which(rownames(dates_df_noskincancer_cases) %in% vector_date_case$eid ),]

dates_df_noskincancer_controls=dates_df_noskincancer_controls[which(rownames(dates_df_noskincancer_controls) %in% controls_eid2 ),]



saveRDS(dates_df_noskincancer_cases2, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/dates_df_noskincancer_cases2.rds")
saveRDS(dates_df_noskincancer_controls, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/dates_df_noskincancer_controls.rds")