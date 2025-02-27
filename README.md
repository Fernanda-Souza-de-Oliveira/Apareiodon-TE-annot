This repository contains the detailed methods and code used in the paper entitled "A curated transposable element library from the genome of Neotropical fish Apareiodon sp. gives insight into its distribution and activity". Publication submitted to Chromosome Research.

The code and files presented here aim to aid in the reproducibility of the analysis presented in the paper.


Files: 

detailed_methods - Detailed methods and code used to generate the data on the TE distribution and activity on Apareiodon sp. genome

coverage_superf.sh - Script for the coverage analysis on the different TE superfamilies.

anova_tukey.R - The statistical difference in the distribution of TEs in the genome was calculated and plotted according to this R script. For the statistical differences of specific TE superfamilies between scaffolds, the same script was applied, on separated coverage files for each superfamily.

termlength.py - Script to extract the terminal branch lengths from the family trees.

te_age.R - Script for calculation of family's terminal branch length medians and statistical analysis of differences between superfamilies.

te_len.py - Script for extraction of sequences from the annotation file that possess at least 90% of its consensus size. 

apareiodon_te_consensus.fa - Consensus sequences of TE families obtained from the Apareiodon sp. genome.

apareiodon_te_annot.gff.gz - Genome annotation of TEs in Apareiodon sp. genome.

uncurated_library.fasta - Consensus sequences from the uncurated TE library.
