library(tidyverse)
library(data.table)

data <- data.frame(fread("ukb26390.csv"))
mycoding <- data.frame(fread("Codings_Showcase.csv"))
withdrawn=as.character(read.csv("w19266_20200204.csv")[,1])
data <-filter(data,!(eid %in% withdrawn)) # 502506 observations

# Extract the covariates of interest
#eid
eid <- data$eid 

# Age at recruitment
print(colnames(data)[grep('21022',colnames(data))])
age_at_baseline <- data$X21022.0.0
sum(is.na(age_at_baseline)) # no missing values


# Age
print(colnames(data)[grep("34",colnames(data))])
year_of_birth <- data$X34.0.0
# convert year of birth to age
age <- 2021 - year_of_birth
sum(is.na(age)) # no missing values

# check forinconsistencies
table(age - age_at_baseline)


# sex
print(colnames(data)[grep("31",colnames(data))])
sex <- data$X31.0.0
# 1 = male and 0 = female
sum(is.na(sex)) # no missing values

# body mass index
print(colnames(data)[grep("21001",colnames(data))])
bmi <- data$X21001.0.0
sum(is.na(bmi)) # 3105 missing values

#qualifications
print(colnames(data)[grep("6138",colnames(data))])
q1 <- data$X6138.0.0
qualifications_id = "100305"
mycoding_field=mycoding[which(mycoding[,1]==qualifications_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
q1 <- (mycoding_field[as.character(q1),"Meaning"])
q2 <- data$X6138.0.1
mycoding_field=mycoding[which(mycoding[,1]==qualifications_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
q2 <- (mycoding_field[as.character(q2),"Meaning"])
q3 <- data$X6138.0.2
q4 <- data$X6138.0.3

#	Job involves heavy manual or physical work	
print(colnames(data)[grep("816",colnames(data))])
jihmopw <- data$X816.0.0
jihmopw_coding_id = "100301"
mycoding_field=mycoding[which(mycoding[,1]==jihmopw_coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
jihmopw <- as.factor(mycoding_field[as.character(jihmopw),"Meaning"])
# too many missing values: 215356

# ethnicity
print(colnames(data)[grep("21000",colnames(data))])
ethnicity <- data$X21000.0.0
ethnicity_coding_id="1001"
mycoding_field=mycoding[which(mycoding[,1]==ethnicity_coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
# Recode ethnicity:
ethnicity <- as.factor(mycoding_field[as.character(ethnicity),"Meaning"])

# nap during day
print(colnames(data)[grep("1190",colnames(data))])
nap_during_day <- data$X1190.0.0
coding_id="100343"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
nap_during_day <- as.factor(mycoding_field[as.character(nap_during_day),"Meaning"])

#smoking status
print(colnames(data)[grep("20116",colnames(data))])
smoking_status <- data$X20116.0.0
coding_id="90"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
smoking_status <- as.factor(mycoding_field[as.character(smoking_status),"Meaning"])

# alcohol intake frequency
print(colnames(data)[grep("1558",colnames(data))])
alcohol_intake_frequency <- data$X1558.0.0
coding_id="100402"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
alcohol_intake_frequency <- as.factor(mycoding_field[as.character(alcohol_intake_frequency),"Meaning"])

# skin colour
print(colnames(data)[grep("1717",colnames(data))])
skin_colour <- data$X1717.0.0
coding_id="100431"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
skin_colour <- as.factor(mycoding_field[as.character(skin_colour),"Meaning"])

# childhood sunburn occasions
print(colnames(data)[grep("1737",colnames(data))])
childhood_sunburn <- data$X1737.0.0
coding_id="100291"
childhood_sunburn <- na_if(childhood_sunburn,-1)
childhood_sunburn <- na_if(childhood_sunburn,-3)

# overall health rating
health_rating <- data$X2178.0.0
coding_id="100508"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
health_rating <- as.factor(mycoding_field[as.character(health_rating),"Meaning"])

# Ease of skin tanning
ease_of_skin_tanning <- data$X1727.0.0
coding_id="100432"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
ease_of_skin_tanning <- as.factor(mycoding_field[as.character(ease_of_skin_tanning),"Meaning"])

# Time spent outdoors summer
time_spent_outdoors_summer <- data$X1050.0.0
coding_id="100329"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
time_spent_outdoors_summer <- na_if(time_spent_outdoors_summer,-1)
time_spent_outdoors_summer <- na_if(time_spent_outdoors_summer,-3)
#time_spent_outdoors_summer[time_spent_outdoors_summer==-10] <- 0

# Time spent outdoors winter
time_spent_outdoors_winter <- data$X1060.0.0
coding_id="100329"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
time_spent_outdoors_winter <- na_if(time_spent_outdoors_summer,-1)
time_spent_outdoors_winter <- na_if(time_spent_outdoors_summer,-3)

#Salad/ raw vegetable intake
vegetable_intake <- data$X1299.0.0
coding_id="100373"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]

# fresh fruit intake
fruit_intake <- data$X1309.0.0

# beef intake
beef_intake <- data$X1369.0.0
coding_id="100377"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
beef_intake <- as.factor(mycoding_field[as.character(beef_intake),"Meaning"])

# oily fish intake
oily_fish_intake <- data$X1329.0.0
coding_id="100377"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
oily_fish_intake <- as.factor(mycoding_field[as.character(oily_fish_intake),"Meaning"])

# poultry intake
poultry_intake <- data$X1359.0.0
coding_id="100377"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
poultry_intake <- as.factor(mycoding_field[as.character(poultry_intake),"Meaning"])

# lamb/mutton intake
lamb_mutton_intake <- data$X1379.0.0
coding_id="100377"
mycoding_field=mycoding[which(mycoding[,1]==coding_id),]
mycoding_field=mycoding_field[,-1]
rownames(mycoding_field)=mycoding_field[,1]
lamb_mutton_intake <- as.factor(mycoding_field[as.character(lamb_mutton_intake),"Meaning"])

# tea intake 
tea_intake <- data$X1488.0.0

# Final Recoded covariates data set
fcds <- data.frame(eid,age_at_baseline,age,sex,bmi,ethnicity,nap_during_day,
                   smoking_status,alcohol_intake_frequency,skin_colour,
                   childhood_sunburn,health_rating,ease_of_skin_tanning,
                   time_spent_outdoors_summer, time_spent_outdoors_winter, 
                   vegetable_intake, fruit_intake, beef_intake, oily_fish_intake,
                   poultry_intake, lamb_mutton_intake, tea_intake)


saveRDS(fcds, "/rds/general/project/hda_students_data/live/Group7/General/Carolina/covariates.rds")
