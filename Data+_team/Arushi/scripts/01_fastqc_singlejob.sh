#!/bin/bash -e
#SBATCH --job-name=fastqc_single
#SBATCH --time=12:00:00
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/fastqc_single.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/fastqc_single.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=arushi.singh@duke.edu

module load FastQC

RAW_DIR=/work/clh162/OysterRNA24/rawreads
FASTQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/fastqc_raw

mkdir -p $FASTQC_OUT

echo "Starting FastQC on all raw read files..."
echo "Raw reads directory: $RAW_DIR"
echo "Output directory: $FASTQC_OUT"

fastqc -o $FASTQC_OUT -t $SLURM_CPUS_PER_TASK ${RAW_DIR}/*.fastq.gz

echo "FastQC complete."
