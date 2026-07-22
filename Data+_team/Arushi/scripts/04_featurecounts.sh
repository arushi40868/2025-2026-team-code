#!/bin/bash -e
#SBATCH --job-name=featurecounts
#SBATCH --time=4:00:00
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/featurecounts.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/featurecounts.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

## Load featureCounts / Subread ##
module load Subread || module load subread || module load SUBREAD

## Set paths ##
PROJECT_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi
BAM_DIR=${PROJECT_DIR}/aligned_bam
COUNT_DIR=${PROJECT_DIR}/featureCounts_counts
GTF=/work/clh162/OysterRNA24/hisat2_align/Cv_genome_RU_2025_shared/Cvi_RU25.gtf

mkdir -p ${COUNT_DIR}
mkdir -p ${PROJECT_DIR}/logs

echo "BAM directory: ${BAM_DIR}"
echo "Count directory: ${COUNT_DIR}"
echo "GTF file: ${GTF}"

echo "Checking input files..."
ls -lh ${BAM_DIR}/*sorted.bam
ls -lh ${GTF}

echo "Running featureCounts..."

featureCounts \
  -T ${SLURM_CPUS_PER_TASK} \
  -p \
  -B \
  -C \
  -t exon \
  -g gene_id \
  -a ${GTF} \
  -o ${COUNT_DIR}/combined_featureCounts_gene_counts.txt \
  ${BAM_DIR}/*sorted.bam

echo "featureCounts complete!"
echo "Output:"
ls -lh ${COUNT_DIR}
