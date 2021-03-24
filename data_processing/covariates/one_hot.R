data <- fcds_final

data$age_at_baseline <- NULL

data$sex <- as.integer(data$sex)
data$family_history_cancer <- as.integer(data$family_history_cancer)
data$childhood_sunburn <- as.integer(data$childhood_sunburn)
data$time_spent_outdoors_summer <- as.integer(data$time_spent_outdoors_summer)
data$time_spent_outdoors_winter <- as.integer(data$time_spent_outdoors_winter)
data$vegetable_intake <- as.integer(data$vegetable_intake)
data$fruit_intake <- as.integer(data$fruit_intake)
data$tea_intake <- as.integer(data$tea_intake)
data$water_intake <- as.integer(data$water_intake)

dt <- data.table(data)
covariates_hot_encoded <- one_hot(dt)
