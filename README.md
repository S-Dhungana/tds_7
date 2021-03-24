# Translation Data Sciences
TDS Group 7 Repository

This repository contains all of the code and scripts run by Group 7, and organised according to the analysis plan of the project. 

* Case Extraction: skin cancer is chosen as cancer of focus, and cases are extracted from the Biobank dataset
* Data Processing: covariates of interest are selected, comorbidities identified, and all biomarker, comorbidities and covariates datasets are imputed and prepared for analysis steps; controls matched for cases, and data split conducted for train and test
   * Biomarker
   * Comorbidities
   * Covariates
* Descriptive Analysis: preliminary exploration of the data is conducted, looking at distributions of variables and preliminary differences between cases and controls for the relevant datasets
* Network Analysis: networks analysed for interactions between different comorbidities investigated in this project
* Predictive Models: models constructed with the following algorithms, to derive best classification of cases vs. controls by looking at highest value of AUC values
   * Logistic Regression
   * LASSO
   * Random Forest
   * SVM Models
 * Sensitivity Analysis: sensitivity analysis conducted for the following models, based on different time windows
    * Logistic Regression
    * LASSO
    * SVM Models
 
