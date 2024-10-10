#!/bin/bash


file=$1
lines=$(cat $file)

for line in $lines
do
	#echo $line
	echo $line
	grep $line apareiodon_te_annot.gff | bedtools coverage -a genome_windows.bed -b - > ${line}_genome_coverage.out	

done
