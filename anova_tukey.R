library (ggplot2)
library(dplyr)
library(multcompView)

#ANOVA and Tukey statistics for TE genome coverage
genome_coverage <- read.delim(file="genome_coverage.out",sep="\t",header=FALSE)

gen_cov<-genome_coverage %>% filter(V7!=0)

anova<-aov(V7~V1, data=gen_cov)
summary.aov(anova)

tukey<-TukeyHSD(anova)
print(tukey)

cld<-multcompLetters4(anova,tukey)
print(cld)

Tk <- group_by(gen_cov, V1) %>%
  summarise(mean=mean(V7), quant=quantile(V7, probs = 0.75)) %>%
  arrange(desc(mean))

cld <- as.data.frame.list(cld$V1)
Tk$cld <- cld$Letters
print(Tk)

gen_cov$V2 <- gen_cov$V2/1000000

ggplot(data=gen_cov, aes(x=V2,y=V7,fill=V1)) + 
  geom_point(aes(x=V2,y=V7), size = 0.01) + 
  facet_wrap(.~factor(V1, levels = c("cs1","cs2","cs3","cs4","cs5","cs6","cs7","cs8","cs9","cs10","cs11","cs12","cs13","cs14","cs15","cs16","cs17","cs18","cs19","cs20","cs21","cs22","cs23","cs24","cs25","cs26","cs27","cs28")), ncol=5, scales="free_x") +
  ylim(0.00,0.50) +
  theme(legend.position='none', 
        text = element_text(size = 6),
        axis.text = element_text(size=4.5), 
        panel.spacing.y=unit(0.001, "lines"),
        strip.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA)) +
  labs(y="Genome Coverage", x="Scaffold Position (Mbp)") +
  ggtitle("TE genome coverage")
