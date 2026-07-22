#!/bin/bash -e
#SBATCH --job-name=trimreads_array
#SBATCH --time=7-00:00:00
#SBATCH --array=1-36%4
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trimreads_%A_%a.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trimreads_%A_%a.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=arushi.singh@duke.edu
#SBATCH --account=wonglab

## activate RNA-seq environment with updated version of Trim Galore ##
source /hpc/home/as1685/miniconda3/etc/profile.d/conda.sh
conda activate multiqc_env

# ensure correct version is functioning
trim_galore -V

## Set Paths ##
RAW_DIR=/work/clh162/OysterRNA24/rawreads
TRIMMED_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/trimmedreads

mkdir -p $TRIMMED_DIR
mkdir -p /work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs

## Set up direction/path to each sample ##
# Make list of sample names without _R1/_R2 suffix
SAMPLES=($(ls ${RAW_DIR}/*_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//' | xargs -n 1 basename))

# Index an individual sample from the list for this array task
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID-1]}

# Define R1 and R2 for the sample
R1=${RAW_DIR}/${SAMPLE}_R1_001.fastq.gz
R2=${RAW_DIR}/${SAMPLE}_R2_001.fastq.gz

## Run Trimming ##
echo "Trimming ${SAMPLE}..."
echo "R1: ${R1}"
echo "R2: ${R2}"
echo "Output directory: ${TRIMMED_DIR}"

trim_galore \
    --paired ${R1} ${R2} \
    --quality 30 \
    --cores ${SLURM_CPUS_PER_TASK} \
    --output_dir $TRIMMED_DIR

echo "Trimming completed for ${SAMPLE}"

conda deactivate
