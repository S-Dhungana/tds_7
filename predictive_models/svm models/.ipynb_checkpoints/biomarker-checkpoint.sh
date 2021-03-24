#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=1:mem=3gb

module load anaconda3/personal

cd /rds/general/project/hda_students_data/live/Group7/General/Sarvesh/Scripts

Rscript biomarker.R