# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

library(data.table)
library(openxlsx)
library(tidyverse)

# read Biobank dataset
mydata=data.frame(fread("/rds/general/user/ems2817/projects/hda_students_data/live/Group7/General/ukb26390.csv"))
print(mydata$X40006.0.0) # Baseline cancer only, since consequent cancers may be explained by the previous

# determine column of interest
cancer_ICD_col<- (colnames(mydata)[grep("40006",colnames(mydata))])
cancer_ICD_col

# codings dataset load
mycoding=read.csv("/rds/general/user/ems2817/projects/hda_students_data/live/Group7/General/Codings_Showcase.csv")

# look at field of interest (19 = ICD10)
coding_id="19"
print(head(mycoding))
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
head(mycoding_field)
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
print(head(rownames(mycoding_field)))

# Recoded categories:
as.character(mycoding_field[as.character(mydata$X40006.0.0),"Meaning"])
mycoding_field[,1]

# Skin cancer
head(mycoding_field)

# Create list of values equated to skin cancer
skincancer =c(c(paste0("C", 430:449)))

# Filter coding fields based on cancer of interest
coding_skincancer = filter(mycoding_field, Value %in% skincancer)
coding_skincancer

# Show results of coding fields that are for cancer of interest
mycoding_skincancer=coding_skincancer[,-1]
rownames(coding_skincancer)=coding_skincancer[,1]
print(coding_skincancer)
coding_skincancer[,1]

codes_skincancer = as.character(coding_skincancer[,1])
print(codes_skincancer)

# Extract skin cancer cases
skincancer_cases = subset(mydata,X40006.0.0 %in% codes_skincancer) 
skincancer_cases

saveRDS(skincancer_cases,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/skincancer_cases.rds")