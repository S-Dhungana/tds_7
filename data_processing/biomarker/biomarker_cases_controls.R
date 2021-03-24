# Working directories
getwd()
setwd("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts")

# Relevant packages
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")

# Read dataset
cases_eid <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/cases_eid.rds")
controls_eid <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/controls_eid.rds")
biomarker_final <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_final.rds")

# Filter out cases and control biomarkers
cases_biomarker <- filter(biomarker_final, (eid %in% cases_eid))
controls_biomarker <- filter(biomarker_final, (eid %in% controls_eid))

# Save datasets
saveRDS(controls_biomarker,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/controls_biomarker.rds")

saveRDS(cases_biomarker,
        "/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/cases_biomarker.rds")
