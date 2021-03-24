rm(list=ls())

## Parameters

args=commandArgs(trailingOnly=TRUE)
nchunks=as.numeric(args[1])
ichunk=as.numeric(args[2])

#load packages
library(caTools)
library(glmnet)
library(dplyr)
library(ROCR)
library(stats)

#Load data
everything <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/comorbidities_covariates_biomarkers_01.rds")
cov <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/covariates_hot_encoded.rds")
MATCHIT <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/old datasets/MATCHIT.rds")
match_case_control <- data.frame( "case" = rownames(MATCHIT[["match.matrix"]]), "control" = MATCHIT[["match.matrix"]][,1])

#remove cov from everything
comor <- everything[, -c(8140:8162)]

#leftjoin comor and cov
rownames(comor) <- comor$eid
cov$eid <- as.character(cov$eid)
data <- left_join(comor, cov, by = c("eid"))
rownames(data) <- rownames(comor)

#select only incident cases
filter_incident_cases <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Sensitivity_analysis/filter_incident_cases.rds")
data <- data[(data$eid %in% filter_incident_cases),]

#remove eid column
eidcol <- which(colnames(data) == "eid")
data <- data[, -eidcol]

#change variables sex and family_history_cancer now have values of 0-1 instead of 1-2
data$sex <- ifelse(data$sex == 1, 0, 1)
data$family_history_cancer <- ifelse(data$family_history_cancer == 1, 0, 1)

#removing from matched individuals that were removed from main study
data_cases <- rownames(data[data$status==1,])
data_controls <- rownames(data[data$status==0,])
matched <- match_case_control[data_cases, ]
matched$case <- as.character(matched$case)
matched$control <- as.character(matched$control)
matched <- matched[(matched[,"control"] %in% data_controls),]
matched <- matched[(matched[,"case"] %in% data_cases),]

cases_and_controls <- c(as.character(matched$case), as.character(matched$control))
drop <- which(!(rownames(data) %in% cases_and_controls))
data <- data[-drop, ]


#split data into test and training set (matched pairs of case and control have to be in same sets)
controls <- rownames(data[data[,1] == 0, ])
set.seed(2)
split <- sample.split(controls, SplitRatio = 0.8)
controls_80 = controls[split]
matched_80<- matched[matched$control %in% controls_80, ]
matched_20 <- matched[!(matched$control %in% controls_80), ]
train <- data[c(matched_80[, 1], matched_80[, 2]),]
test <- data[c(matched_20[,1], matched_20[, 2]),]

#separte into X and y
y_train <- train[, 1]
X_train <- as.matrix(train[,-1])
y_test <- test[, 1]
X_test <- as.matrix(test[,-1])

X_train <- scale(X_train)
X_test <- scale(X_test)

X_train <- scale(X_train)
drop_train <- which(is.nan(X_train[1,]))
X_train[, drop_train] <- 0

X_test <- scale(X_test)
drop_test <- which(is.nan(X_test[1,]))
X_train[, drop_test] <- 0


lasso_coef <- rep(0, length=(ncol(X_train)))
for(l in 1:2){
  
  i <- l + (2 * (ichunk - 1))
  
#Fold
k <- 10 #k-fold cross validation
set.seed(ichunk)
matched_80$fold <- sample(rep(1:k, length=length(matched_80[,1])))
fold <- data.frame("ids" = c(matched_80$case, matched_80$control), "fold_ids" = c(matched_80$fold, matched_80$fold))
print("fold")

#LASSO model

lasso_stab <- cv.glmnet(X_train, y_train, family = "binomial", type.measure = "auc", foldid = fold$fold_ids)
coef.sub = coef(lasso_stab, s = "lambda.1se")[-1]
coef_it <- coef.sub/coef.sub
coef_it[is.nan(coef_it)] <- 0
lasso_coef <- lasso_coef + coef_it
}

saveRDS(lasso_coef, paste0("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/window01/Lasso_stab__window_comor_cov_bio01_", ichunk, ".rds"))
