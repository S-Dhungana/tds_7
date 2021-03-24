data <- as.data.frame(comorbidities_final)
data2 <- data[1:100, 1:100]


data3 <- as.data.frame(comorbidities_final_nodates)
data4 <- data3[1:100, 1:100]


columns <-c(1:8157)
columns <- columns*2 + 1
columns[8158]


data4 <- data[, columns]
saveRDS(data4, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_final_onlydates.rds")

#### corellation matrix
#data <- comorbidities_final_nodates_final
#data2 <- data[1:100, 1:100

#tmp=as.matrix(data)
#heatmap(tmp, Colv = NA, Rowv = NA) 
#tmp_cor <- cor(tmp)
#heatmap(x = tmp_cor, symm = TRUE, Colv = NA, Rowv = NA, col=cm.colors(256))

#diag(tmp)=NA
#d3heatmap(tmp, Rowv=FALSE, Colv=FALSE, cexRow=0.7, cexCol=0.7, color="Blues")
