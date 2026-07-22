# Climate Change Impacts on Farmed and Wild Oysters

## Project Overview

Farmed Eastern oysters (*Crassostrea virginica*) experience Sudden Unusual Mortality Syndrome (SUMS), especially during the summer months. SUMS may be driven by interactions among genetics, care strategies, and environmental conditions. Examining global patterns in gene expression gives us insight into how oysters respond to their environment.

## Goals

We had two main goals for this project:

1. Explore differences in gene expression between the two farms, CMAST and DAF.
2. Analyze how gene expression varied across spatiotemporal scales alongside corresponding environmental data, including salinity, temperature, pH, dissolved oxygen, and precipitation.

## Sample Information

The 18 oyster samples were divided as follows:

| Category | Description |
|---|---|
| Biological replicates | Three oysters: SJ1, SJ2, and SJ3 |
| Timepoints | June 20, July 22, and August 19, 2024 |
| Sites | Duke Aquafarm (DAF) and NC State's Center for Marine Sciences and Technology (CMAST) |
| Total samples | 3 oysters × 3 timepoints × 2 sites = 18 samples |

## RNA-seq Pipeline

1. Raw sequencing data (`.fastq`)
2. Quality and adapter trimming with Trim Galore
3. Quality control with FastQC and MultiQC
4. Alignment with HISAT2
5. Gene-level quantification with featureCounts
6. Differential expression analysis with DESeq2
7. Environmental correlation analysis using Spearman correlations
8. Co-expressed gene analysis using WGCNA
9. Linear regression modeling
10. Genome comparison
11. Gene Ontology analysis using GOseq

## Repository Structure

*TBA*

## Tools Used

### Bash and Command-Line Tools

- FastQC
- MultiQC
- Trim Galore
- HISAT2
- SAMtools
- featureCounts
- DIAMOND

### R and RStudio

Analyses were conducted in RStudio version `2024.4.0.735` using:

- DESeq2
- WGCNA
- GOseq
- BiocManager
- `enrichGO`

## How to Run

### 1. Set Up the Conda Environment

Set up the required Conda environments and install the following tools:

- DIAMOND
- FastQC
- MultiQC
- Trim Galore

### 2. Quality Control and Alignment

Run the relevant SLURM scripts:

- **Data quality control:** See `Sophie/fastqc.sh` and `Sophie/multiqc.sh` for examples.
- **Trimming:** See `Sophie/trim.sh` for an example.
- **Alignment:** See `Sophie/alignment.sh` for an example.
- **Feature counting:** See `Sophie/gene_counts.sh` for an example.

### 3. Gene Expression Analysis

Run the DESeq2 analysis using the featureCounts gene-count matrix and sample metadata.

Example count matrix:

```text
Arushi/featureCounts_counts/combined_featureCounts_gene_counts.csv
```

For visualization of pairwise comparison results, see the **Statistics** and **Visualizations** sections in:

```text
Anna/rnaseq_piplin_RU25.Rmd
```

### 4. WGCNA

Run the WGCNA analysis using the gene-expression and environmental matrices.

Primary WGCNA workflow:

```text
Arushi/scripts/07_sophie_counts_wgcna_environment.Rmd
```

### 5. Environmental Regression

Run:

```text
Arushi/scripts/06_environmental_regression.Rmd
```

Use the environmental matrix:

```text
Arushi/scripts/environmental_events_7day_spline_final.csv
```

### 6. Genome Comparison

For statistical tests comparing alignment rates, see:

```text
Sophie/genome_comparison.Rmd
```

For the full GOseq pipelines using the Rutgers 2017, Rutgers 2025, and Yale 2025 reference genomes, see:

```text
Anna/RU17_rnaseq_piplin.Rmd
Anna/rnaseq_piplin_RU25.Rmd
Anna/Yale25_rseq_piplin.Rmd
```

## Outputs

The project produces:

- FastQC and MultiQC reports (`.html` or `.zip`)
- Alignment files (`.bam`)
- Gene-level count matrices (`.csv` or `.txt`)
- PCA plots
- Sample-distance heatmaps
- Differential expression tables
- MA plots and volcano plots
- WGCNA module assignments
- Module–trait correlation plots
- Environmental regression tables
- Gene Ontology enrichment results

## Main Takeaways

- Gene expression varied more by location and month than by oyster identity.
- WGCNA linked gene-module eigengenes to dissolved oxygen, salinity, conductivity, and month.
- The black module showed a significant association with salinity (`p = 2.5 × 10⁻⁵`, `R² = 0.990`).
- These patterns may support early stress detection and targeted monitoring during periods of rapid environmental change.
- Future studies should validate these findings across more sites and sampling events to help reduce oyster mortality.

## Limitations

- The study had a small sample size and included only 2024 data. Adding 2025 data and future sampling years would strengthen the analysis.
- Environmental variables were highly correlated with month. For example, each month had its own precipitation level, making precipitation difficult to separate from temporal effects.
- Additional sites, sampling events, and experimental validation are needed.
- Observed relationships represent associations and should not be interpreted as causal effects.

## Future Work

Our work this summer will provide the Wong Lab with a pipeline for performing similar analyses on 2025 tissue-sample reads and environmental data. This will allow the lab to investigate whether the patterns identified in the 2024 data continue into the following year.

Our gene-expression findings also provide an opportunity for the team to conduct targeted qPCR analyses to remeasure and validate the expression patterns identified this summer. Overall, we hope that our findings on the relationship between environmental factors and gene expression will help future researchers better understand why SUMS may occur and how oyster mortality could be reduced.

## Acknowledgements

We would like to thank Dr. Tom Schultz, Dr. Juliet Wong, our project lead, Callie Hundley, our project manager, and Henry Sun for their guidance and support throughout the summer.
