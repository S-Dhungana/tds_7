rm(list=ls())
setwd("/rds/general/project/hda_students_data/live/Group7/General")

#Load dataset nodates
data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_final_onlydates.rds")
data2 <- data
data <- data2

#select only cases
skincancer =c(c(paste0("C", 430:449, "_date"))) #all skin cancer icd10 codes
cancer <- data[, skincancer] #select only skin cancer columns
droprows_non_skincancer <- which(rowSums(cancer) == 0)
cases <- cancer[-droprows_non_skincancer, ] #select only cases
min_date <- apply(cases, 1, function(x) min(x[x>0])) # select earliest date of diagnosis of a skin cancer for each patient

#create data frame with eid and respective date of diagnosis
skincancer_date <- data.frame(matrix(0, ncol = 2, nrow = length(min_date)))
colnames(skincancer_date) <- c("eid", "skincancer_diagnosis_date")
skincancer_date[, 1] <- names(min_date)
skincancer_date[, 2] <- min_date
saveRDS(skincancer_date, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/cases_date_extraction.rds")


#select only controls
#remove skincancer comorbidity?
controls <- data[droprows_non_skincancer, ] #select only controls
min_date <- apply(controls, 1, function(x) min(x[x>0])) # select earliest date of diagnosis of a skin cancer for each patient
saveRDS(controls, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/controls_date_extraction.rds")










