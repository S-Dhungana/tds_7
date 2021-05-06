rm(list=ls())
setwd("/rds/general/project/hda_students_data/live/Group7/General")

#Input data set with icd code meaning converted into icd code + meaning for a column icd 9 and icd 10
data <- readRDS("Final/cases_controls_hes.rds")

#Remove episodes without date
drop_rows <- which(data$epistart == "") #obtain rows for which no date available
if(!is.na(drop_rows[1])){
  data <-  data[-drop_rows, ] #remove these rows
}
#Remove rows with NA in both icd code 10 column
drop_rows2 <- which(is.na(data$diag_icd10)) #obtain rows for no icd codes
if(!is.na(drop_rows2[1])){
  data <-  data[-drop_rows2, ] #remove these rows
}

### Create new dataframe with eid and binary comorbidity variables

#patients id
eid <- unique(data$eid)

#use unique values as column names
unique_comorbidities <- unique(data[, 3])
column_names <- c("eid")
for(i in 1:length(unique_comorbidities)){
  column_names <- c(column_names, unique_comorbidities[i], paste0(unique_comorbidities[i], "_date"))
}

#create dataframe
comorbidity_data <- matrix(0, ncol = length(column_names), nrow = length(eid))
rownames(comorbidity_data) <- eid
colnames(comorbidity_data) <- column_names
comorbidity_data[, 1] <- eid

# Change to 1 where patient has a comorbidity
for(i in 1:dim(data)[1]){
  row_eid <- as.character(data[i, "eid"])
  comorbidity <- as.character(data[i, 3])
  #date <- data[i, "epistart"]
  #date <- as.Date(date, tryFormats = "%d/%m/%Y")
  comorbidity_data[row_eid, comorbidity] <- 1
  #comorbidity_data[row_eid, paste0(comorbidity, "_date")] <- date
}

saveRDS(comorbidity_data, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_final_nodates.rds")


