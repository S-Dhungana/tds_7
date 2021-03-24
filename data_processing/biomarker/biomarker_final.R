# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

# Relevant packages
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")
if(!require(mice)) install.packages("mice", repos = "http://cran.us.r-project.org")

# Read dataset
biomarker_imputed <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_imputed.rds")
biomarker_cut <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_cut.rds")

biomarker_impute <- biomarker_imputed$data

# Extract eid column to add to dataframe
eid <- biomarker_cut[,1]
length(eid)

# Change data type from matrix to data frame
biomarker_impute <- as.data.frame(biomarker_impute)
biomarker_impute

# Join column of biomarkers with eid column
biomarker_impute <- cbind(biomarker_impute, eid)
biomarker_impute
str(biomarker_impute)

# Rearrange columns to have eid as first column
biomarker_impute <- biomarker_impute[, c(29, 1:28)]
biomarker_impute

# Round values in data frame to have at most 3 digits after decimal 
biomarker_impute <- round(biomarker_impute, digits = 3)
biomarker_impute

# Export finished dataset
saveRDS(biomarker_impute,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_final.rds")
