## TE
index/repeatmasker
nohup RepeatMasker -pa 8 -species "dicentrarchus labrax" ../Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta -libdir /home/s2250706/anaconda3/envs/repeatmasker/share/RepeatMasker/Libraries -html -dir . > repeatmasker_seabass.out 2>&1 &
awk '{print $5"\t"$6"\t"$7"\t"$11}' Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta.out > TE.raw.bed
cp TE.raw.bed TE.bed

## GERP
bigBedToBed gerp_constrained_elements.dicentrarchus_labrax.bb gerp_constrained_elements.dicentrarchus_labrax.bed


## Bedtools
bedtools intersect -a ../21428.bcftools.bed_withsnpeff.bed -b gerp_constrained_elements.dicentrarchus_labrax.bed -wo > gerp.21428.bed.txt
bedtools intersect -a ../21428.bcftools.bed_withsnpeff.bed -b TE.bed -wo -f 0.50 -r > TE.21428.bed.txt













