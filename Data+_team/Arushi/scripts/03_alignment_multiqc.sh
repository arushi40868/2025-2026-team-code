#!/bin/bash -e
#SBATCH --job-name=alignment_multiqc
#SBATCH --time=01:00:00
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/alignment_multiqc.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/alignment_multiqc.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

# Activate conda environment containing MultiQC
source /hpc/home/clh162/miniconda3/etc/profile.d/conda.sh
conda activate RNA-seq

## Set paths ##
LOG_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs
BAM_DIR=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/aligned_bam
MULTIQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/multiqc_report_alignment

mkdir -p $MULTIQC_OUT
mkdir -p $LOG_DIR

## Run MultiQC ##
echo "Running MultiQC on HISAT2 alignment logs..."
echo "Log directory: $LOG_DIR"
echo "BAM directory: $BAM_DIR"
echo "Output directory: $MULTIQC_OUT"

multiqc $LOG_DIR $BAM_DIR -o $MULTIQC_OUT

echo "Alignment MultiQC complete!"

conda deactivate
