# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

# Read data
mydata = readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/skincancer_cases.rds")

# Read dataset which denotes participants who have withdrawn
withdrawn=as.character(read.csv("/rds/general/project/hda_students_data/live/Group7/General/w19266_20200204.csv")[,1])
mydata <-filter(mydata,!(eid %in% withdrawn))

# Create dataset with consented cases
saveRDS(mydata,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/consented_cases.rds")