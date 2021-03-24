
data_1<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/data0_1.rds")
ICD10_1<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/uni_variate_logistic/significant_ICD_1.rds")
data<- data_1[ ,which(colnames(data_1) %in% ICD10_1)]
data<-cbind(data_1['status'], data)


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
thr <- max(as.vector(pval)[p.adjust(as.vector(pval), method = "BH") < 0.01]) #method BH and 0.05 or 0.01?
pair_index <- which(pval <= thr, arr.ind = TRUE)

#Plot
edges = data.frame(comorbidities1 = colnames(data)[pair_index[,1]], comorbidities2 = colnames(data)[pair_index[, 2]])
head(edges)
library(igraph)


data_co <- subset(data_1, data_1[,1]==0)
sums <- colSums(data_1[,2:8138])
sums <- sort(sums, decreasing = TRUE)
sums100 <- sums[1:100]
d_co <- names(sums100)

data_ca <- subset(data_1, data_1[,1]==1)
sums <- colSums(data_1[,2:8138])
sums <- sort(sums, decreasing = TRUE)
sums100 <- sums[1:100]
d_ca <- names(sums100)


#d_ca<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Intro_material/comor100_ca.rds")
#d_co<-readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Intro_material/comor100_co.rds")

d_both=intersect(d_ca,d_co)
d_diff1=setdiff(d_ca,d_co)
    d_diff2=setdiff(d_co,d_ca)
    
    
    library(dplyr)
    
    `%notin%` <- Negate(`%in%`)
    
    network = graph_from_data_frame(d = edges, directed = FALSE)
    V(network)$color = ifelse(V(network)$name %in% d_both,
                              yes = "tomato", ifelse(
                                V(network)$name %in% d_diff1, yes = "skyblue",
                                ifelse(
                                  V(network)$name %in% d_diff2, yes = "green",
                                  no = "grey")))

V(network)$frame.color = V(network)$color
V(network)$label.color = "black"
V(network)$label.cex = 0.5
V(network)$size = 0.2 * (degree(network)) + 1
E(network)$color = "grey30"
E(network)$width=0.3
pdf("Network_top_diseases_timewindow1.pdf")
set.seed(1)
plot(network, layout = layout_with_graphopt(network))
dev.off()
