setwd("/rds/general/project/hda_students_data/live/Group7/General/Demetris")


install.packages("mice")
library(mice)

fcds <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Demetris/fcds.rds")

# We need to remove "eid" column in order to impute missing data
eid <- fcds$eid
fcds <- fcds[,2:25]

# check amount of missing values
summary(fcds)
# no column has more than 10% missing values

# imputation

imputed_fcds <- mice(fcds)
summary(imputed_fcds)
complete_fcds <- complete(imputed_fcds,1)

# Time to add back "eid"
complete_fcds <- cbind(eid,fcds)




# correlation plot
mycor = cor(fcds[,2:3])
pheatmap(mycor, cluster_rows = FALSE, cluster_cols = FALSE, border = NA,
         breaks = seq(-1, 1, length.out = 100))


