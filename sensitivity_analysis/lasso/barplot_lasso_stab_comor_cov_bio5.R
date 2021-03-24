
comor <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/Model_dataset/comorbidities_covariates_bio_train1.rds")
comor <- comor[,-1]

lasso_coef <- rep(0, length=dim(comor)[2])
for (i in 1:10){
  data <- readRDS(paste0("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/Lasso_stab_comor_cov_bio5/Lasso_stab_comor_cov_bio5_", i, ".rds"))
  lasso_coef <- lasso_coef + data
}

#Bar plot of comorbidity selection
lasso.prop = lasso_coef/100
names(lasso.prop) <- colnames(comor)
lasso.prop = sort(lasso.prop, decreasing = TRUE)

pdf("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/barplots/stability_comor_cov_bio5.pdf")
plot(lasso.prop[lasso.prop > 0.2], type = "h", col = "navy",
     lwd = 3, xaxt = "n", xlab = "", ylab = expression(beta),
     ylim = c(0, 1.2), las = 1)
text(lasso.prop[lasso.prop > 0.2] + 0.07, labels = names(lasso.prop[lasso.prop > 0.2]), pos = 3, srt = 90, cex = 0.7)
dev.off()