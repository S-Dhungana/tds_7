
library(tidyverse)
library(dplyr)

# vector of dates of cases diagnosis

vector=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector.rds")

dates_df_noskincancer_cases=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/dates_df_noskincancer_cases2.rds")



diff_outcome_comorbidity_ca <- matrix(0, ncol = length(dates_df_noskincancer_cases), nrow = nrow(dates_df_noskincancer_cases))
rownames(diff_outcome_comorbidity_ca) <- rownames(dates_df_noskincancer_cases)
colnames(diff_outcome_comorbidity_ca) <- colnames(dates_df_noskincancer_cases)


for(i in 1:length(vector)){
  for (j in 1:ncol(dates_df_noskincancer_cases)){
  diff_outcome_comorbidity_ca[i,j]<- vector[i] - dates_df_noskincancer_cases[i,j]
  }}


saveRDS(diff_outcome_comorbidity_ca, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/diff_outcome_ca2.rds")

