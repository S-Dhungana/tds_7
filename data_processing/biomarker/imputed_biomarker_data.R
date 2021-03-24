# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

# Relevant packages
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")
if(!require(mice)) install.packages("mice", repos = "http://cran.us.r-project.org")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("impute")
library(impute)

# Read dataset
biomarker_data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_data.rds")

# Read columns with more than 30% missing data
missing_col<- colMeans(is.na(biomarker_data)) > 0.30
which(missing_col)

# Read rows with more than 50% missing data
missing_row <- rowMeans(is.na(biomarker_data)) > 0.50
sum(missing_row)

# Import cases and controls dataset
cases_eid <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/cases_eid.rds")
controls_eid <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/controls_eid.rds")

# Make cases and controls biomarker datasets
cases_biomarkers <- filter(biomarker_data, (eid %in% cases_eid))
controls_biomarkers <- filter(biomarker_data, (eid %in% controls_eid))

# CASES BIOMARKERS
## Read columns with more than 30% missing data
cases_bio_na_col<- colMeans(is.na(cases_biomarkers)) > 0.30
which(cases_bio_na_col)

## Read rows with more than 50% missing data
cases_bio_na_row <- rowMeans(is.na(cases_biomarkers)) > 0.50
sum(cases_bio_na_row)

# CONTROLS BIOMARKERS
## Read columns with more than 30% missing data
controls_bio_na_col<- colMeans(is.na(controls_biomarkers)) > 0.30
which(controls_bio_na_col)

## Read rows with more than 50% missing data
controls_bio_na_row <- rowMeans(is.na(controls_biomarkers)) > 0.50
sum(controls_bio_na_row)

# No point in splitting cases and controls, so it is not done
# REMOVAL OF COLUMNS FROM THE ENTIRE DATASET
col_drops <- c("Oestradiol","Rheumatoid factor")
biomarker_data <- biomarker_data[ , !(names(biomarker_data) %in% col_drops)]

# Check missing values from dataset after columns removal 
# Read columns with more than 30% missing data
missing_col<- colMeans(is.na(biomarker_data)) > 0.30
which(missing_col)

# Read rows with more than 50% missing data
missing_row <- rowMeans(is.na(biomarker_data)) > 0.50
sum(missing_row)

# Make list of missing row indices
missing_row_list <- which(missing_row)

# Make list of eid with the indices 
missing_bio_eid <- biomarker_data$eid[missing_row_list]
missing_bio_eid

# Remove eid from biomarker dataset that has missing values
bio_data_cut <-filter(biomarker_data,!(eid %in% missing_bio_eid))

# Final check to see how many missing values in final dataset
# Read columns with more than 30% missing data
missing_col_cut<- colMeans(is.na(bio_data_cut)) > 0.30
which(missing_col_cut)

# Read rows with more than 50% missing data
missing_row_cut <- rowMeans(is.na(bio_data_cut)) > 0.50
sum(missing_row_cut)

# Save dataset 
saveRDS(bio_data_cut,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_cut.rds")

# Remove eid column for imputation
bio_data_noeid <- select(bio_data_cut, -1)
bio_data_noeid

# Impute values using impute.knn
biomarker_imputed <-impute.knn(as.matrix(bio_data_noeid))

# Export finished dataset
saveRDS(biomarker_imputed,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_imputed.rds")