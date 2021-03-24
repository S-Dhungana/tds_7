data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/analysis_dataset.rds")


#Dataset 3+
data_3 <- apply(data, 2, function(x) {ifelse((x == "3-5"), 1, 0)})

#Dataset 1+
data_1 <- apply(data, 2, function(x) {ifelse((x == "1-3"), 1, 0)})

#Dataset 1 year prior to diagnosis
data_0 <- apply(data, 2, function(x) {ifelse((x == "0-1"), 1, 0)})

data_0_5 <- data_1 + data_3



saveRDS(data_0_5, "/rds/general/project/hda_students_data/live/Group7/General/Final/data1_5.rds")
saveRDS(data_0, "/rds/general/project/hda_students_data/live/Group7/General/Final/data0_1.rds")


test=data_0[, 1:3]
