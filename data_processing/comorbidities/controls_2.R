library(tidyverse)
library(dplyr)

# vector of dates of cases diagnosis
# vector of dates of cases diagnosis
#vector_date_case= readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector_date_case.rds")
vector2=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/vector2.rds")

dates_df_noskincancer_controls=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/dates_df_noskincancer_controls.rds")

diff_outcome_comorbidity_co=readRDS("/rds/general/project/hda_students_data/live/Group7/General/Eleonore/diff_outcome_co.rds")

#create empty dataframe size of dates_df_noskincancer
df_date_co <- matrix(0, ncol = length(dates_df_noskincancer_controls), nrow = nrow(dates_df_noskincancer_controls))
rownames(df_date_co) <- rownames(dates_df_noskincancer_controls)
colnames(df_date_co) <- colnames(dates_df_noskincancer_controls)

      
for( i in 1:length(vector2)) {
  for (j in 1:ncol(dates_df_noskincancer_controls)){
    if (diff_outcome_comorbidity_co[i,j]==vector2[i]) {  
      df_date_co[i,j]<- 'No comorbidity'
    } else  if (diff_outcome_comorbidity_co[i,j]<0){
      df_date_co[i,j]<- 'posterior'
    } else if (diff_outcome_comorbidity_co[i,j]==0) {
      df_date_co[i,j]<- 'co occurent'
    } else if (diff_outcome_comorbidity_co[i,j]>=0 & diff_outcome_comorbidity_co[i,j]<=365.25) {
      df_date_co[i,j]<- '0-1'
    } else if (diff_outcome_comorbidity_co[i,j]> 365.25 & diff_outcome_comorbidity_co[i,j]<=(3*365.25)) {
      df_date_co[i,j]<- '1-3'
    } else if (diff_outcome_comorbidity_co[i,j]> (3*365.25) & diff_outcome_comorbidity_co[i,j]<=(5*365.25)) {
      df_date_co[i,j]<- '3-5'
    } else if (diff_outcome_comorbidity_co[i,j]> (5*365.25) &diff_outcome_comorbidity_co[i,j]<=(10*365.25)) {
      df_date_co[i,j]<- '5-10'
    } else if (diff_outcome_comorbidity_co[i,j]> (10*365.25)) {
      df_date_co[i,j]<- '10+'
    }
  }
}




saveRDS(df_date_co, "/rds/general/project/hda_students_data/live/Group7/General/Eleonore/diag_date_recode_co.rds")