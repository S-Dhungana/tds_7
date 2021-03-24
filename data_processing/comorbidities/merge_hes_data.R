rm(list=ls())
setwd("/rds/general/project/hda_students_data/live/Group7/General")

#Input data set with icd code meaning converted into icd code + meaning for a column icd 9 and icd 10

for (i in 0:1) {
  file_name <- paste0("Carolina/hes_data/hes_comorbidities", i,".rds")
  dataset <- as.data.frame(readRDS(file_name))
  assign(paste0("data", i), dataset)
}


combine <- function(data1, data2){
#    if(rownames(data1)[(dim(data1)[1])] == rownames(data2)[1]){
#      data1[dim(data1)[1],] <- data1[dim(data1)[1],] + data2[1,]
#      drop_rows <-c(1L)
#      data2 <-  data2[-drop_rows, ]
#    }
    data_tot <- merge(data1, data2, by = "eid")
  return(data_tot)
}

data_total <- combine(data0, data1)
#data_total <- combine(data_total, data2)
#data_total <- combine(data_total, data3)
#data_total <- combine(data_total, data4)
#data_total <- combine(data_total, data5)
#data_total <- combine(data_total, data6)
#data_total <- combine(data_total, data7)
#data_total <- combine(data_total, data8)
#data_total <- combine(data_total, data9)
#data_total <- combine(data_total, data10)
#data_total <- combine(data_total, data11)
#data_total <- combine(data_total, data12)
#data_total <- combine(data_total, data13)


saveRDS(data_total, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/hes_data/hes_comorbidities_final.rds")

readRDS()

