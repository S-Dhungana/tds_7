rm(list=ls())

library('data.table')
library('ukbtools')

setwd("/rds/general/project/hda_students_data/live/General/")

hes=data.frame(fread("hesin.txt", nrows=100))
# hes$epistart # start of episode date
episode_ID=paste0(hes$eid, "_", hes$ins_index)

hes_diag=data.frame(fread("hesin_diag.txt", nrows=100))
episode_ID_diag=paste0(hes_diag$eid, "_", hes_diag$ins_index)


###create comorbidity data set
icd=c()
code_meaning=c()
meaning=c()
column=c()
comor=c()
eid=c
#translate icd codes
for(j in 5:dim(hes_diag)[2]) {
  if(j < 7) {
    icd <- 9
  } else {
    icd <- 10
  }
  for(i in 1:dim(hes_diag)[1]){
    code_meaning <- ukb_icd_code_meaning(icd.code = hes_diag[i, j], icd.version = icd) #returns icd code + meaning
    meaning <- unlist(strsplit(as.character(code_meaning[2]), split=" ", fixed=TRUE))[2] # removes icd code
    hes_diag[i, j] <- meaning
  }
}

column <- apply(hes_diag, 1, function(x) {which(!is.na(x))}) #returns position of column where a comorbidity is present

comor <- c(rep(0, dim(hes_diag)[1])) #create null vector
for(i in 1:dim(hes_diag)[1]){
  comor[i] <- hes_diag[i, column[i]] #fill vector with merged info from the different icd columns
}
hes_diag$comor <- comor

### Create new dataframe with eid and binary comorbidity variables

#patients id
eid <- unique(hes_diag$eid)

#use unique values as column names
comorbidities <- unique(hes_diag[, 9])

#create dataframe
comorbidity_data <- as.data.frame(matrix(0, ncol = length(comorbidities) + 1, nrow = length(eid)))
colnames(comorbidity_data) <- c("eid", comorbidities)
rownames(comorbidity_data) <- eid
comorbidity_data[, 1] <- eid

# Change to 1 where patient has a comorbidity
for(i in 1:dim(hes_diag)){
  row_eid <- as.character(hes_diag[i, 1])
  comorbidity <- as.character(hes_diag[i, 9])
  comorbidity_data[row_eid, comorbidity] <- 1
}

#save data set
saveRDS(comorbidity_data,"/rds/general/project/hda_students_data/live/Group7/General/Eleonore/comorbidity_data_final.RDS")










