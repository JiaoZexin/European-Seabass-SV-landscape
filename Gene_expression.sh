nohup featureCounts -T 8 -a /home/s2250706/data/seabass/2.index/gtf/Dicentrarchus_labrax-GCA_905237075.1-2021_08-genes.gtf -o counts.txt -p -B -C *.bam > test1.out 2>&1 &

library(DESeq2)
library(pheatmap)

# counts.file
counts <- read.table("counts.txt", header = TRUE, sep = "\t", comment.char = "#", row.names = 1)

# count_matrix
count_matrix <- counts[ , 6:ncol(counts)]
colnames(count_matrix) <- gsub("dlabrax2021\\.ENA\\.|\\.1\\.bam", "", colnames(count_matrix))

# sample_info
sample_info <- data.frame(
  row.names = colnames(count_matrix),
  tissue = colnames(count_matrix)
)

#gene list
gene_list <- read.table("67SVs_99Genes/gene.list.99.txt", header = FALSE, stringsAsFactors = FALSE)[,1]


# TPM 
calculate_tpm <- function(counts, lengths) {
  rate <- counts / lengths
  tpm <- t(t(rate) / colSums(rate)) * 1e6
  return(tpm)
}

gene_length <- counts$Length  
raw_counts <- counts[ , 6:ncol(counts)]
tpm_matrix <- calculate_tpm(raw_counts, gene_length)
colnames(tpm_matrix) <- gsub("dlabrax2021\\.ENA\\.|\\.1\\.bam", "", colnames(tpm_matrix))
selected_tissues <- c("brain", "olfactory_lobe", "gill", "liver", "spleen", "skin", "skeletal_muscle")
genes_present <- gene_list[gene_list %in% rownames(tpm_matrix)]
mat_tpm_subset <- tpm_matrix[genes_present, ]
mat_tpm_ordered <- mat_tpm_subset[, selected_tissues]
sample_info_ordered <- sample_info[selected_tissues, , drop = FALSE]

pheatmap