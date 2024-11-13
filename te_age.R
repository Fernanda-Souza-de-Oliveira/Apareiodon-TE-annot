# Median terminal branch length
library(nortest)
library(FSA)
library (ggplot2)
library(dplyr)
library(rcompanion)

medians <- read.delim(file="medians.tbl",sep="\t",header=FALSE)

# Normality test
shapiro <- shapiro.test(medians$V2)
print (shapiro)

# Kruskal-Wallis test
kw<-kruskal.test(V2~V1, data=medians)
print(kw)

# Dunn's post-hoc test
dunn <-dunnTest(V2~V1, data = medians, method = "bonferroni")
print(dunn)

# cld and boxplot
cld <- cldList(comparison = dunn$res$Comparison, p.value = dunn$res$P.adj, threshold = 0.05) [1:2]
names(cld)[1]<-"V1"
print(cld)

ggplot(data=medians,aes(x=factor(V1, level=c('Ty3', 'Pao', 'ERV', 'Copia', 'DIRS', 'L2', 'Rex', 'L1', 'RTE', 'I', 'SINE', 'TcMar', 'hAT', 'Harbinger', 'PiggyBac', 'EnSpm', 'Helitron', 'Polinton')),y=V2, fill = V1)) + 
  geom_boxplot(outlier.size = 0.2) +
  ylim(0, 0.3) +
  labs (x="Superfamilies", y="Median terminal branch length") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), text = element_text(size = 8), axis.text.x = element_text(angle = 90, vjust=0.3), legend.position="none") +
  geom_text(data = cld, aes(x = V1, y = 0.3, label = Letter), size = 2, vjust=20, hjust =-0.8) +
  scale_fill_manual(values=c("#008B00", "#008B00", "#CD0000", "#008B00", "#CD0000", "#CD0000", "#CD0000", "#1874CD", "#1874CD", "#1874CD", "#008B00", "#CD0000", "#CD0000", "#1874CD", "#1874CD", "#00C5CD", "#CD0000", "#008B00")) +
  scale_x_discrete(labels=c("Ty3/Gypsy", "Bel-Pao", "ERV", "Copia", "DIRS", "L2", "Rex-Babar", "L1", "RTE", "I", "SINE", "Tc1-Mariner", "hAT", "PIF-Harbinger", "PiggyBac", "EnSpm", "Helitron", "Polinton"))

###########################################################
# Relationship between medians and number of insertions

# Spearman correlation
s_cor <- read.delim(file = "medians_ncopies_superf.tbl",sep="\t",header=TRUE)
mtbr <- s_cor$mtbr
ncopies <- s_cor$ncopies

cor.test(ncopies, mtbr, method=c("spearman"))
