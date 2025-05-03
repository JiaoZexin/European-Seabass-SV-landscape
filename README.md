# European Seabass Structural Variation Landscape Analysis

This project focuses on the detection, characterization, and analysis of structural variations (SVs) in the genome of **European seabass** (*Dicentrarchus labrax*), with the goal of uncovering genomic features relevant to phenotypic traits such as disease resistance and adaptation.

## 🔬 Objectives

- Detect and validate structural variations in seabass whole-genome sequence data
- Filter and annotate high-confidence SVs
- Link SVs with gene expression data and enriched biological functions
- InterPro Domain analysis
- TE/GERP



## Project Structure

```
.
├── Annotation.sh           # SNPeff annotation based on SV vcf file
├── Chi-square.py           # Script for chi-square statistical testing for Interpro domain
├── Enrichment.sh           # Shell script to analyze functional enrichment of SVs
├── Gene_expression.sh      # Script to integrate or analyze gene expression data
├── SV_detection.sh         # Main pipeline for SV calling from WGS data
├── SV_filter.sh            # Post-processing script to filter high-confidence SVs
└── TE_GERP.sh              # bedtools for checking overlap SVs with TE/GERP
└── README.md               # Project overview and usage instructions
```


## Usage

Ensure you have the appropriate dependencies installed (`samtools`, `vcftools `, `smoove`, `bedtools`, `R`, etc.) before running the scripts.


```bash
bash *.sh
python3 *.py
```



## Notes

- Scripts are modular and can be adapted to other species.
- Input/output formats should follow standard VCF/BED/GTF conventions.
- Please cite relevant tools or datasets if used in publications.


## Contributions

Contributions, issues, and feature requests are welcome. Feel free to fork and submit a pull request.

