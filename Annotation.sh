data/genomes
ln -s index/Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta seabass_GCA_905237075.1.fa
mk seabass_GCA_905237075.1
cd seabass_GCA_905237075.1
ln -s index/Dicentrarchus_labrax-GCA_905237075.1-2021_08-genes.gtf genes.gtf
cd ../../
echo "seabass_GCA_905237075.1.genome:seabass_GCA_905237075.1" >> snpEff.config
java -jar snpEff.jar build -c snpEff/snpEff.config -gtf22 -v seabass_GCA_905237075.1 -noCheckCds -noCheckProtein 

nohup java -Xmx20G -jar snpEff/snpEff.jar -c snpEff.config -v seabass_GCA_905237075.1 -csvStats 21428.csv -stats 21428.html 21428.final.vcf 1> 21428.eff.vcf 2> 21428.snpeff.out &