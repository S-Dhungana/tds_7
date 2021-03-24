#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=96gb
#PBS -N sevnodes1core
#PBS -J 1-10

cd /rds/general/project/hda_students_data/live/Group7/General/Final/LASSO/stability_analysis/Lasso_stab_comor1
module load anaconda3/personal

ichunk=$PBS_ARRAY_INDEX
nchunks=10

Rscript Lasso_stab_comor1.R $nchunks $ichunk
