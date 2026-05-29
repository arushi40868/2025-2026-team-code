#!/bin/bash -e
#SBATCH --job-name=hisat2_index
#SBATCH --time=7-00:00:00
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/hisat2_index.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/hisat2_index.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

## Load module ##
module load HISAT2

## Set Paths ##
GENOME=/work/clh162/OysterRNA24/hisat2_align/c.virginica_genome.fa
GTF=/work/clh162/OysterRNA24/hisat2_align/c.virginica_annotation.gtf
INDEX_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/hisat2_index

mkdir -p ${INDEX_DIR}
mkdir -p /work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs

## Create HISAT2 index with splice sites and exons ##
echo "Extracting splice sites..."
hisat2_extract_splice_sites.py ${GTF} > ${INDEX_DIR}/c.virginica_splice_sites.txt

echo "Extracting exons..."
hisat2_extract_exons.py ${GTF} > ${INDEX_DIR}/c.virginica_exons.txt

echo "Building HISAT2 index..."
hisat2-build \
    -p ${SLURM_CPUS_PER_TASK} \
    -ss ${INDEX_DIR}/c.virginica_splice_sites.txt \
    -exon ${INDEX_DIR}/c.virginica_exons.txt \
    ${GENOME} ${INDEX_DIR}/C.virginica_index

echo "HISAT2 index complete!"
echo "Index prefix: ${INDEX_DIR}/C.virginica_index"
