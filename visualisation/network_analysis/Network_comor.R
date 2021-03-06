data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/data10.rds")
whole_data <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/analysis_dataset.rds")
data[,1] <- whole_data$status

data <- subset(data, data$V1==1)

pval = as.data.frame(matrix(1, ncol = length(colnames(data)), nrow = length(colnames(data))))

#Function to calculate pvalues for each comorbidity pair
binary_pvalue <- function(data, i, j) {
  pair <- with(data, table(data[,i], data[,j]))
  if(i != j & (sum(data[,i]) *  sum(data[,j])) > 0){
    #cs <- log2((pair[2,2] + 1)/( (sum(data[,i]) *  sum(data[,j])/ (length(colnames(data))^2)) + 1))
    if( 2 >= 1){
      fish_test <- fisher.test(matrix(c(pair[2,2], pair[1,2], pair[2,1], pair[1,1]), nrow = 2, ncol = 2))
      pval <-fish_test$p.value
    }else{
      pval <- 1
    }
  }else{
    pval <- 1
  }
  return(pval)
}

for(i in 1:length(colnames(data))){
  for (j in 1:length(colnames(data))) {
    if(i < j){
      value <- binary_pvalue(data, i, j)
      pval[i,j] <- value
    }
  }
}

#BH correction
pval <- as.matrix(pval)
thr <- max(as.vector(pval)[p.adjust(as.vector(pval), method = "none") < 0.05]) #method BH and 0.05 or 0.01?
pair_index <- which(pval <= thr, arr.ind = TRUE)

#Plot
edges = data.frame(comorbidities1 = colnames(data)[pair_index[,1]], comorbidities2 = colnames(data)[pair_index[, 2]])
head(edges)
library(igraph)

network = graph_from_data_frame(d = edges, directed = FALSE)
V(network)$color = "skyblue"
V(network)$frame.color = V(network)$color
V(network)$label.color = "black"
V(network)$label.cex = 0.5
V(network)$size = 0.2 * (degree(network)) + 1
E(network)$color = "grey30"
pdf("Network_test.pdf")
set.seed(1)
plot(network, layout = layout_with_graphopt(network))
dev.off()
