results10<- readRDS("/rds/general/project/hda_students_data/live/Group7/General/Final/results10.rds")

library(dplyr)
library(tidyverse)

results10$code=rownames(results10)
results10= merge(results10, comorbidities_categories, by='code')
results10<-results10%>%
  drop_na()
results10$ICD10=substr(results10$code, 1, 1)

results10$logp=-log10(results10$pval)
bonf10=-log10(0.05/nrow(results10))
results10$significant=results10$logp>bonf10
significant_ICD_10=results10$code[which(results10$significant==TRUE)]
significant_pval=results10$pval[which(results10$significant==TRUE)]
meaning10=t(data.frame(data.frame(t(sapply(as.character(significant_ICD_10), FUN=ukb_icd_code_meaning)))$meaning))
ICD10_10=as.character(meaning10[,1])
final10=data.frame(ICD10_10,significant_pval)
final10 <- final10[order(significant_pval),]
final10 


names(chap)[2]='ICD10'
ten_bis=merge(results10,chap, by='ICD10')

legend_description<-ggplot(
  ten_bis, aes(as.numeric(row.names(ten_bis)), y=-log10(pval), color=Title))+
  geom_point()+
  geom_hline(yintercept= -log10(0.05/nrow(ten_bis)), linetype="dashed", color = "red")+
  geom_text(aes(label=ifelse(-log10(pval)>-log10(0.05/nrow(ten_bis)),as.character(code),''),hjust=0,vjust=0),show.legend=FALSE)+
  #ggtitle("Time= 10 years prior to diagnosis of skin cancer") +
  xlab("ICD10 codes")+
  ylim(0,60)+
  theme(axis.text.x = element_blank())+
  theme(aspect.ratio = 1)+
  theme(legend.box = 'vertical')+
  theme_void()+
  theme(legend.key.size = unit(1, 'cm'), #change legend key size
        legend.key.height = unit(1, 'cm'), #change legend key height
        legend.key.width = unit(1.5, 'cm'), #change legend key width
        legend.title = element_text(size=5), #change legend title font size
        legend.text = element_text(size=8)) #change legend text font size
#+theme(legend.position = "none")

results<-ggplot(
  ten_bis, aes(as.numeric(row.names(ten_bis)), y=-log10(pval), color=ICD10))+
  geom_point()+
  geom_hline(yintercept= -log10(0.05/nrow(ten_bis)), linetype="dashed", color = "red")+
  geom_text(aes(label=ifelse(-log10(pval)>-log10(0.05/nrow(ten_bis)),as.character(code),''),hjust=0,vjust=0),show.legend=FALSE)+
  ggtitle("Time= 10 years prior to diagnosis of skin cancer") +
  xlab("ICD10 codes")+
  ylim(0,60)+
  theme(axis.text.x = element_blank())+
  theme(aspect.ratio = 1)+
  theme(legend.box = 'horizontal')
  

results

library(patchwork)
library(gplots)

figure <- ggarrange(results, legend_description,
                    labels = c("A", "B"),
                    ncol = 2, nrow = 1)
figure


results/legend_description
