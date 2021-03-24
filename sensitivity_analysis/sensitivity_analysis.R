#Sensitivity analyses 


# Extract new dataset 


##INCIDENT CASE DATASET

filter_incident_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")
df=comorbidities_covariates_01[which(comorbidities_covariates_01$eid %in% filter_incident_cases),]



table=data.frame(MATCHIT$match.matrix)
table$cases=rownames(table)
table$controls=table$MATCHIT.match.matrix

final=data.frame(table[which(table$cases %in% incident_cases),])
final2=final[,2:3]

cases_final=final2$cases
controls_final=as.character(final2$controls)

filter_incident_cases=c(cases_final,controls_final)
saveRDS(filter_incident_cases, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")


filter_incident_cases[38414]
## TIME FRAMES

#0 to minus 1 year

data0_1=data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data0_1.rds"))

logical2<-rownames(data0_1) %in% cases_eid
logical3<-rownames(data0_1) %in% controls_eid
data0_1$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
data0_1$status<-ifelse(logical3==TRUE ,0,data0_1$status)


#minus 1 to minus 5
data1_5=data.frame(readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data1_5.rds"))

logical2<-rownames(data1_5) %in% cases_eid
logical3<-rownames(data1_5) %in% controls_eid
data1_5$status<-ifelse(logical2==TRUE | logical3==TRUE ,1,NA)
data1_5$status<-ifelse(logical3==TRUE ,0,data1_5$status)


saveRDS(data1_5, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/data1_5.rds")
saveRDS(data0_1, "/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/data0_1.rds")
