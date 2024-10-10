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

ggplot(gen_cov,aes(x=factor(V1, level=c('cs1', 'cs2', 'cs3', 'cs4', 'cs5', 'cs6', 'cs7', 'cs8', 'cs9', 'cs10', 'cs11', 'cs12', 'cs13', 'cs14', 'cs15', 'cs16', 'cs17', 'cs18', 'cs19', 'cs20', 'cs21', 'cs22', 'cs23', 'cs24', 'cs25', 'cs26', 'cs27', 'cs28')),y=V7)) + 
  geom_boxplot(outlier.size = 0.2) +
  ylim(0, 0.1) +
  labs (x="Scaffold", y="coverage") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), text = element_text(size = 8)) +
  geom_text(data = Tk, aes(x = V1, y = quant, label = cld), size = 2, vjust=-1, hjust =-0.8, angle = 90)
 