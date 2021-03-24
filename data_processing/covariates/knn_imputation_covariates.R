fcds <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/fcds.rds")


library(mltools)
library(data.table)
library(impute)
library(rMIDAS)
library(reticulate)
library(dplyr)


fcds$ethnicity <- NULL
fcds$sex <- as.factor(fcds$sex)
fcds$childhood_sunburn <- as.integer(fcds$childhood_sunburn)
fcds$time_spent_outdoors_summer <- as.integer(fcds$time_spent_outdoors_summer)
fcds$time_spent_outdoors_winter <- as.integer(fcds$time_spent_outdoors_winter)
fcds$vegetable_intake <- as.integer(fcds$vegetable_intake)
fcds$fruit_intake <- as.integer(fcds$fruit_intake)
fcds$tea_intake <- as.integer(fcds$tea_intake)
fcds$water_intake <- as.integer(fcds$water_intake)
fcds$family_history_cancer <- as.factor(fcds$family_history_cancer)

dt <- data.table(fcds)

fcds_hot_encoded <- one_hot(dt)

knn_imputation<- impute.knn(as.matrix(fcds_hot_encoded))

# knn_imputation is a list containing data, rng.seed and rng.state

fcds_hot_encoded_imputed <- knn_imputation$data
fcds_hot_encoded_imputed <- data.frame(fcds_hot_encoded_imputed)

saveRDS(fcds_hot_encoded_imputed,"/rds/general/project/hda_students_data/live/Group7/General/Demetris/fcds_hot_encoded_imputed.rds")

# We also need the data set with the categories not being one hot encoded.
# new data set called fcds_final
# revert one-hot encoding by lines below
sex <- colnames(fcds_hot_encoded_imputed[,4:5])[apply(fcds_hot_encoded_imputed[,4:5], 1, which.max)]
health_rating <- colnames(fcds_hot_encoded_imputed[,7:11])[apply(fcds_hot_encoded_imputed[,7:11], 1, which.max)]
smoking_status <- colnames(fcds_hot_encoded_imputed[,13:15])[apply(fcds_hot_encoded_imputed[,13:15], 1, which.max)]
alcohol_intake_frequency <- colnames(fcds_hot_encoded_imputed[,16:21])[apply(fcds_hot_encoded_imputed[,16:21], 1, which.max)]
nap_during_day <- colnames(fcds_hot_encoded_imputed[,22:24])[apply(fcds_hot_encoded_imputed[,22:24], 1, which.max)]
skin_colour <- colnames(fcds_hot_encoded_imputed[,25:31])[apply(fcds_hot_encoded_imputed[,25:31], 1, which.max)]
ease_of_skin_tanning <- colnames(fcds_hot_encoded_imputed[,33:37])[apply(fcds_hot_encoded_imputed[,33:37], 1, which.max)]
beef_intake <- colnames(fcds_hot_encoded_imputed[,42:46])[apply(fcds_hot_encoded_imputed[,42:46], 1, which.max)]
oily_fish_intake <- colnames(fcds_hot_encoded_imputed[,47:53])[apply(fcds_hot_encoded_imputed[,47:53], 1, which.max)]
poultry_intake <- colnames(fcds_hot_encoded_imputed[,54:59])[apply(fcds_hot_encoded_imputed[,54:59], 1, which.max)]
lamb_mutton_intake <- colnames(fcds_hot_encoded_imputed[,60:64])[apply(fcds_hot_encoded_imputed[,60:64], 1, which.max)]
family_history_cancer <- colnames(fcds_hot_encoded_imputed[,67:68])[apply(fcds_hot_encoded_imputed[,67:68], 1, which.max)]


fcds_final <- cbind(fcds_hot_encoded_imputed[,c(1:3,6)],sex,health_rating,fcds_hot_encoded_imputed[,c(12,32)],
                    smoking_status,alcohol_intake_frequency,nap_during_day,skin_colour,
                    ease_of_skin_tanning,fcds_hot_encoded_imputed[,38:41],
                    beef_intake,oily_fish_intake,poultry_intake,lamb_mutton_intake,
                    fcds_hot_encoded_imputed[,65:66],family_history_cancer)

height <- fcds_hot_encoded_imputed$height
childhood_sunburn <- fcds_hot_encoded_imputed$childhood_sunburn

saveRDS(fcds_final,"/rds/general/project/hda_students_data/live/Group7/General/Demetris/fcds_final.rds")


