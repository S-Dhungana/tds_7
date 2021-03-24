# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")

### Biomarker measurements
# Biomarker measurements are stored in a different dataset:
biomarker=data.frame(fread("/rds/general/project/hda_students_data/live/Group7/General/ukb27725.csv"))

# You can use the "Biomarker_annotation.xlsx" file to identify the biomarkers based on
# their field IDs:
bio_annotation=read.xlsx("/rds/general/project/hda_students_data/live/Group7/General/Biomarker_annotation.xlsx")

# Select only columns that give biomarker values, and exclude the irrelevant columns
# Extract list of coding numbers for the biomarkers
head(bio_annotation)
bio_list <- c(bio_annotation[,1])
bio_list

# Create list of columns to filter for biomarker dataset
bio_codes <- c(c(paste0("X", bio_list, '.0','.0')))
bio_codes

# Add eid to the list as variable of interest
bio_cols <- c(bio_codes, 'eid')

# Filter out columns not of interest in the biomarker set
biomarker_data <- biomarker[, colnames(biomarker) %in% bio_cols]
biomarker_data

# Filter out withdrawn participants
withdrawn <- as.character(read.csv("/rds/general/project/hda_students_data/live/Group7/General/w19266_20200204.csv")[,1])
biomarker_data <-filter(biomarker_data,!(eid %in% withdrawn))

# Mutate annotation columns to reflect dataset for biomarkers
bio_annotation <- mutate(bio_annotation, bio_an = UK.Biobank.Field)
bio_annotation
bio_annotation <- mutate(bio_annotation, bio_an= paste0("X",as.character(UK.Biobank.Field),'.0','.0'))
bio_annotation$bio_an

# Set new names for data table
biomarker_data1 <- setnames(biomarker_data, old = bio_annotation$bio_an, new = bio_annotation$Biomarker.name)
biomarker_data1

# Save biomarker dataset as RDS file
saveRDS(biomarker_data1,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_data.rds")
