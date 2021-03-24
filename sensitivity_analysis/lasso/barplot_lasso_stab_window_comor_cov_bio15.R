
coefnames <- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/window15/coefnames.rds")

lasso_coef <- rep(0, length=ncol(coefnames))
for (i in 1:50){
  data <- readRDS(paste0("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/window15/Lasso_stab__window_comor_cov_bio15_", i, ".rds"))
  lasso_coef <- lasso_coef + data
}

#Bar plot of comorbidity selection
lasso.prop = lasso_coef/100
names(lasso.prop) <- colnames(coefnames)
lasso.prop = sort(lasso.prop, decreasing = TRUE)

pdf("/rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/barplots/stability_window_comor_cov_bio15.pdf")
plot(lasso.prop[lasso.prop > 0.2], type = "h", col = "navy",
     lwd = 3, xaxt = "n", xlab = "", ylab = expression(beta),
     ylim = c(0, 1.2), las = 1)
text(lasso.prop[lasso.prop > 0.2] + 0.07, labels = names(lasso.prop[lasso.prop > 0.2]), pos = 3, srt = 90, cex = 0.7)
dev.off()

