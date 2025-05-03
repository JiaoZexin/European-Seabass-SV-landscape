for i in $(cat name.txt);
do bwa mem -t 8 -R '@RG\tID:'${i}'\tPL:illumina\tDS:resequencing\tSM:'${i}'\tLB:Library_1' Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta ${i}_1.fq.gz ${i}_2.fq.gz > ${i}.sam
done

for i in $(cat name.txt);
do samtools view -Sb -o ${i}.bam ${i}.sam
done

for i in $(cat name.txt);
do samtools sort -@ 8 -m 1G -O bam -o ${i}.sorted.bam ${i}.bam
done

for i in $(cat name.txt);
do samtools index ${i}.sorted.bam
done

for i in $(cat name.txt);
do smoove call --outdir smoove/${i}/ --name ${i} --fasta Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta -p 1 ${i}.sorted.bam
done

nohup smoove merge --name seabass -f Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta --outdir ./ ./results-smoove/*smoove.vcf.gz > nohup.smoove.merge.out 2>&1 &

for i in $(cat name.txt);
do smoove genotype -d -x -p 1 --name ${i}-joint --outdir genotype --fasta Dicentrarchus_labrax-GCA_905237075.1-unmasked.fasta --vcf seabass.sites.vcf.gz ${i}.sorted.bam
done

