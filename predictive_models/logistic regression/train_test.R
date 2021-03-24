data<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/new_1.rds")


library(gplots)
library(caTools)
library(ROCR)

set.seed(31)

split = sample.split(data$status, SplitRatio = 0.8)
train = subset(data, split==TRUE)
test = subset(data, split==FALSE)

saveRDS(train, "/rds/general/project/hda_students_data/live/Group7/General/Final/train.rds")
saveRDS(test, "/rds/general/project/hda_students_data/live/Group7/General/Final/test.rds")