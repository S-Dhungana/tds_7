setwd("/rds/general/project/hda_students_data/live/Group7/General/Demetris")

library(mice)

fcds <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/fcds.rds")

# We need to remove "eid" column in order to impute missing data
eid <- fcds$eid
fcds <- fcds[,2:25]

# imputation

imputed_fcds <- mice(fcds)
summary(imputed_fcds)
complete_fcds <- complete(imputed_fcds,1)

# Time to add back "eid"
complete_fcds <- cbind(eid,complete_fcds)

# Save the new file
saveRDS(complete_fcds,"/rds/general/project/hda_students_data/live/Group7/General/Demetris/complete_fcds.rds")
