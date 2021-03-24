data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/analysis_dataset.rds")

#Dataset 10+
data_10 <- apply(data, 2, function(x) {ifelse((x == "10+"), 1, 0)})

#Dataset 5+
data_5 <- apply(data, 2, function(x) {ifelse((x == "5-10"), 1, 0)})
data_5 <- data_10 + data_5

#Dataset 3+
data_3 <- apply(data, 2, function(x) {ifelse((x == "3-5"), 1, 0)})
data_3 <- data_3 + data_5

#Dataset 1+
data_1 <- apply(data, 2, function(x) {ifelse((x == "1-3"), 1, 0)})
data_1 <- data_3 + data_1

#Dataset 0+
data_0 <- apply(data, 2, function(x) {ifelse((x == "0-1"), 1, 0)})
data_0 <- data_0 + data_1

#Dataset co-occurent
data_co <- apply(data, 2, function(x) {ifelse((x == "co occurent"), 1, 0)})

saveRDS(data_10, "/rds/general/project/hda_students_data/live/Group7/General/Final/data10.rds")
saveRDS(data_5, "/rds/general/project/hda_students_data/live/Group7/General/Final/data5.rds")
saveRDS(data_3, "/rds/general/project/hda_students_data/live/Group7/General/Final/data3.rds")
saveRDS(data_1, "/rds/general/project/hda_students_data/live/Group7/General/Final/data1.rds")
saveRDS(data_0, "/rds/general/project/hda_students_data/live/Group7/General/Final/data0.rds")
saveRDS(data_co, "/rds/general/project/hda_students_data/live/Group7/General/Final/data_cooccurent.rds")