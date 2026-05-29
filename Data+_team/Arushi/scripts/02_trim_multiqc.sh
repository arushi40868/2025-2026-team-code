#!/bin/bash -e
#SBATCH --job-name=trim_multiqc
#SBATCH --time=7-00:00:00
#SBATCH --account=wonglab
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trim_multiqc.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/trim_multiqc.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=arushi.singh@duke.edu

# Activate conda environment containing RNA-seq package
source /hpc/home/clh162/miniconda3/etc/profile.d/conda.sh
conda activate RNA-seq

## Set paths ##
FASTQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/fastqc_trimmed
MULTIQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/multiqc_report_trimmed

mkdir -p $MULTIQC_OUT
mkdir -p /work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs

## Run MultiQC ##
echo "Running MultiQC on trimmed FastQC results..."
echo "Input directory: $FASTQC_OUT"
echo "Output directory: $MULTIQC_OUT"

multiqc $FASTQC_OUT -o $MULTIQC_OUT

echo "Trimmed MultiQC complete!"

conda deactivate
