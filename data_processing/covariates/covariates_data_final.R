data <- data.frame(fread("ukb26390.csv"))
mycoding <- data.frame(fread("Codings_Showcase.csv"))
withdrawn=as.character(read.csv("w19266_20200204.csv")[,1])
data <-filter(data,!(eid %in% withdrawn)) # 502506 observations

# add all names of columns that we want to extract
columns_names_to_extract=unname(unlist(read.table("/rds/general/project/hda_students_data/live/Group7/General/Demetris/List_field_ids_to_extract-copy.txt", header=FALSE)))
exact_column_names = c()

# Find the exact name of the columns (i.e "X21022.0.0") and create a new vector with them
# Don't forget that we need to extract "eid" as well
for (i in (columns_names_to_extract)){
exact_column_names = c(exact_column_names,(colnames(data)[grep(paste0("X",i,".0"),fixed = TRUE,colnames(data))]))
} 


# It's time to add "eid" to the vector and it must be the 1st column
exact_column_names <- c("eid",exact_column_names)

# filter the data set to subset rows
covariates_data <- data %>% select(all_of(exact_column_names))

# Check for missing values
for (i in 1:ncol(covariates_data)){
 print(c(exact_column_names[i],sum(is.na(covariates_data[,i]))))
}

#saveRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris")


# Rename columns
covariates_data %>% 
  rename(
    age_at_baseline = X21022.0.0
  )
