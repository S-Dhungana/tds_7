# Relevant packages
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")
if(!require(corrplot)) install.packages("corrplot", repos = "http://cran.us.r-project.org")
if(!require(ggcorrplot)) install.packages("ggcorrplot", repos = "http://cran.us.r-project.org")
if(!require(Hmisc)) install.packages("Hmisc", repos = "http://cran.us.r-project.org")


biomarker_final <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/biomarker_final.rds")
cases_biomarker <- readRDS('/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/cases_biomarker.rds')
controls_biomarker <- readRDS('/rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Data/controls_biomarker.rds')

dim(biomarker_final)
str(biomarker_final)

dim(cases_biomarker)
str(cases_biomarker)

dim(controls_biomarker)
str(controls_biomarker)

controls_biomarker$eid <- as.character(controls_biomarker$eid)
cases_biomarker$eid <- as.character(cases_biomarker$eid)

summary(controls_biomarker)
summary(cases_biomarker)

library(ggplot2)
library(tidyr)
dev.off()

par(mar=c(1,1,1,1))
hist.data.frame(biomarker_final[, c(2:29)])

r <- cor(biomarker_final[, c(2:29)])
ggcorrplot(r)

for(i in c(2:29)){print(c(colnames(biomarker_final)[i],t.test(cases_biomarker[,i],controls_biomarker[,i])$p.value < 0.05))}
