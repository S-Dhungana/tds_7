rm(list=ls())

#load packages
library(caTools)
library(glmnet)
library(dplyr)
library(ROCR)
library(stats)

#Load data
comor <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/new_1.rds")
cov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/covariates_hot_encoded.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])

#leftjoin comor and cov
comor$eid <- rownames(comor)
cov$eid <- as.character(cov$eid)
data <- left_join(comor, cov, by = c("eid"))
rownames(data) <- rownames(comor)

#remove comorbidities
data <- data[, -c(2:8138)]

#remove eid column
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]
#remove status
comor <- data[, -1]

lasso_coef <- rep(0, length=dim(comor)[2])
for (i in 1:10){
  data <- readRDS(paste0("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/cov/Lasso_stab_onlycov_", i, ".rds"))
  lasso_coef <- lasso_coef + data
}

#Bar plot of comorbidity selection
lasso.prop = lasso_coef/100
names(lasso.prop) <- colnames(comor)
lasso.prop = sort(lasso.prop, decreasing = TRUE)
pdf("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/barplots/stability_onlycov.pdf")
plot(lasso.prop[lasso.prop > 0.2], type = "h", col = "navy",
     lwd = 3, xaxt = "n", xlab = "", ylab = expression(beta),
     ylim = c(0, 1.2), las = 1)
text(lasso.prop[lasso.prop > 0.2] + 0.07, labels = names(lasso.prop[lasso.prop > 0.2]), pos = 3, srt = 90, cex = 0.7)
dev.off()
