#!/bin/bash -e
#SBATCH --job-name=alignment_array
#SBATCH --time=7-00:00:00
#SBATCH --array=1-36
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/hisat2_alignment_%A_%a.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/hisat2_alignment_%A_%a.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

## Load modules ##
module load HISAT2
module load SAMtools

## Set Paths ##
TRIMMED_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/trimmedreads
INDEX_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/hisat2_index
BAM_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/aligned_bam

mkdir -p ${BAM_DIR}
mkdir -p /work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs

## Make list of sample names from trimmed R1 files ##
SAMPLES=($(ls ${TRIMMED_DIR}/*_R1_001_val_1.fq.gz | sed 's/_R1_001_val_1.fq.gz//' | xargs -n 1 basename))

## Select sample for this array task ##
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID-1]}

## Define paired trimmed reads ##
R1=${TRIMMED_DIR}/${SAMPLE}_R1_001_val_1.fq.gz
R2=${TRIMMED_DIR}/${SAMPLE}_R2_001_val_2.fq.gz

## Output files ##
SAM_OUT=${BAM_DIR}/${SAMPLE}.sam
BAM_OUT=${BAM_DIR}/${SAMPLE}.bam
SORTED_BAM=${BAM_DIR}/${SAMPLE}_sorted.bam

echo "Starting HISAT2 alignment for sample: ${SAMPLE}"
echo "R1: ${R1}"
echo "R2: ${R2}"
echo "Index directory: ${INDEX_DIR}"
echo "Output directory: ${BAM_DIR}"

## Run HISAT2 alignment ##
hisat2 \
    -p ${SLURM_CPUS_PER_TASK} \
    -x ${INDEX_DIR}/C.virginica_index \
    -1 ${R1} \
    -2 ${R2} \
    -S ${SAM_OUT}

## Convert SAM to BAM ##
samtools view -@ ${SLURM_CPUS_PER_TASK} -bS ${SAM_OUT} > ${BAM_OUT}

## Sort BAM ##
samtools sort -@ ${SLURM_CPUS_PER_TASK} -o ${SORTED_BAM} ${BAM_OUT}

## Index sorted BAM ##
samtools index ${SORTED_BAM}

## Remove intermediate SAM and unsorted BAM to save space ##
rm ${SAM_OUT}
rm ${BAM_OUT}

echo "Alignment complete for sample: ${SAMPLE}"
echo "Sorted BAM: ${SORTED_BAM}"

