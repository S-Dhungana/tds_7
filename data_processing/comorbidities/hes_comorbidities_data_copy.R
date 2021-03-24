rm(list=ls())

#setwd("/rds/general/project/hda_students_data/live/Group7/General")

data <- readRDS('comorbidity_data2.RDS')
######Remove episodes without date?????
drop_rows <- which(data$epistart == "") #obtain rows for which no date available
data <-  data[-drop_rows, ] #remove these rows

#Remove icd code from meaning columns
for(j in 5:dim(data)[2]) {
  for(i in 1:dim(data)[1]){
    if(!is.na(data[i,j])){
      meaning <- unlist(strsplit(as.character(data[i, j]), split=" ", fixed=TRUE)) # removes icd code
      meaning <- meaning[2:length(meaning)]
      meaning <-paste(meaning, collapse = " ")
    } else {
      meaning <- NA
    }
    
    data[i, j] <- meaning
  }
}

#Merge icd meaning 9 and 10 into new column
column <- apply(data[, 5:dim(data)[2]], 1, function(x) {which(!is.na(x))}) #returns position of column where a disease is present
column <- column + 4

comorbidities <- c(rep(0, dim(data)[1])) #create null vector
for(i in 1:dim(data)[1]){
  comorbidities[i] <- data[i, column[i]] #fill vector with merged info from the different icd columns
}
data$comorbidities <- comorbidities

### Create new dataframe with eid and binary comorbidity variables

#patients id
eid <- unique(data$eid)

#use unique values as column names
unique_comorbidities <- unique(data[, 7])
column_names <- c("eid")
for(i in 1:length(unique_comorbidities)){
  column_names <- c(column_names, unique_comorbidities[i], paste0(unique_comorbidities[i], "_date"))
}

#create dataframe
comorbidity_data <- as.data.frame(matrix(0, ncol = length(column_names), nrow = length(eid)))
rownames(comorbidity_data) <- eid
colnames(comorbidity_data) <- column_names
comorbidity_data[, 1] <- eid

# Change to 1 where patient has a comorbidity
for(i in 1:dim(data)[1]){
  row_eid <- as.character(data[i, "eid"])
  comorbidity <- as.character(data[i, "comorbidities"])
  date <- data[i, "epistart"]
  comorbidity_data[row_eid, comorbidity] <- 1
  comorbidity_data[row_eid, paste0(comorbidity, "_date")] <- date
}

write.csv(comorbidity_data, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/hes_comorbidities2.csv")



