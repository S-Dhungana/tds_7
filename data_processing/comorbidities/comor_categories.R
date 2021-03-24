data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_final_nodates_final.rds")
cat <- read.csv("/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_categories.csv")

data <- data [, 1:(dim(data)[2]-1)]

rownames(cat) <- cat$code
cat <- cat[colnames(data), ]

category_type <- as.character(unique(cat$category))
data_cat <- as.data.frame(matrix(0, nrow = dim(data)[1], ncol = length(category_type)))
rownames(data_cat) <- rownames(data)
colnames(data_cat) <- unique(cat$category)

for(i in 1:length(category_type)){
  columns <- which(cat[, 2] == category_type[i])
  if(length(columns) > 1) {
    data_cat[which(rowSums(data[, columns]) > 0), category_type[i]] <- 1
  }else{
    data_cat[which(data[, columns] > 0), category_type[i]] <- 1
  }
}

saveRDS(data_cat, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/comorbidities_categories.rds")