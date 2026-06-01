#!/bin/bash -e
#SBATCH --job-name=multiqc_raw
#SBATCH --time=01:00:00
#SBATCH --output=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/multiqc_raw.out
#SBATCH --error=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/logs/multiqc_raw.err
#SBATCH --partition=common
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=arushi.singh@duke.edu
#SBATCH --account=wonglab

# Activate conda
source /hpc/home/as1685/miniconda3/etc/profile.d/conda.sh
conda activate multiqc_env

## Set paths ##
FASTQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/fastqc_raw
MULTIQC_OUT=/work/clh162/Data+/Arushi/2025-2026-team-code/Data+_team/Arushi/multiqc_report_raw

mkdir -p $MULTIQC_OUT

## Run MultiQC ##
python -m multiqc $FASTQC_OUT -o $MULTIQC_OUT

echo "MultiQC complete!"

conda deactivate
