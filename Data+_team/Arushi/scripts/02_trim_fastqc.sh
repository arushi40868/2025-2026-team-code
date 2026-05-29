#!/bin/bash -e
#SBATCH --job-name=trim_fastqc_array
#SBATCH --time=7-00:00:00
#SBATCH --array=1-36
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trim_fastqc_%a.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trim_fastqc_%a.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

## Load module ##
module load FastQC

## Set paths ##
TRIMMED_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/trimmedreads
FASTQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/fastqc_trimmed

mkdir -p $FASTQC_OUT
mkdir -p /work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs

## Set up direction/path to each sample ##
SAMPLES=($(ls ${TRIMMED_DIR}/*_R1_001_val_1.fq.gz | sed 's/_R1_001_val_1.fq.gz//' | xargs -n 1 basename))

# Index an individual sample from the list for this array task
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID-1]}

# Define R1 and R2 for the trimmed sample
R1=${TRIMMED_DIR}/${SAMPLE}_R1_001_val_1.fq.gz
R2=${TRIMMED_DIR}/${SAMPLE}_R2_001_val_2.fq.gz

## Run FastQC on trimmed samples ##
echo "Running FastQC on trimmed reads for sample: ${SAMPLE}"
echo "R1: ${R1}"
echo "R2: ${R2}"
echo "Output directory: ${FASTQC_OUT}"

fastqc -o ${FASTQC_OUT} -t ${SLURM_CPUS_PER_TASK} ${R1} ${R2}

echo "Trimmed FastQC complete for sample: ${SAMPLE}"
