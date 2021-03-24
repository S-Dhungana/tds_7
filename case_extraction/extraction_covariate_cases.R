#load data
setwd("/rds/general/project/hda_students_data/live/Group7/General/Carolina")

data_covariates <- readRDS("individual_covariates.rds")
data_covariates[1:5,]
data_cancer <- readRDS("skin_cancer.rds")
data_cancer[1:5,]

#extracting skin cancer cases

cancer_id <- data_cancer[["eid"]] 
j <- 1
extract <- data.frame(rep(c(0), times = length(cancer_id)))

for (i in 1:length(cancer_id)) {
  if (data_covariates[i, 1] == cancer_id[j]) {
    extract[j, ] <- data_covariates[i, ]
    j <- j + 1
  }
}


saveRDS(extract, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/covariates_cases.rds")


