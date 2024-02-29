#!/usr/bin/bash

#SBATCH -A b1081
#SBATCH -p b1081
#SBATCH --array=0-7 ## number of jobs to run "in parallel"
#SBATCH -t 10:00:00
#SBATCH --nodes=1 ## how many computers do you need
#SBATCH --ntasks-per-node=8 ## how many cpus or processors do you need on each computer
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name="freesurfer_reconall_\${SLURM_ARRAY_TASK_ID}" ## use the task id in the name of the job
# Outputs ----------------------------------
#SBATCH --output=freesurfer_reconall.%A_%a.out ## use the jobid (A) and the specific job index (a) to name your log file
#SBATCH --mail-user=dianaperez@u.northwestern.edu
#SBATCH --mail-type=ALL
# ------------------------------------------


module purge all
module load freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

IFS=$'\n' read -d '' -r -a subj_ids < subj_ids.txt

# SUBJECT
SUBJ_ID=${subj_ids[$SLURM_ARRAY_TASK_ID]} 

# set up some directory information
SUBJ_DIR=/scratch/dcr8536/FreeSurfer_reruns/sub-"$SUBJ_ID"/

recon-all -i "$SUBJ_DIR"/anat/sub-"$SUBJ_ID"_ses-3_acq-RMS_T1w.nii.gz \
	-T2 "$SUBJ_DIR"/anat/sub-"$SUBJ_ID"_ses-2_acq-iso_run-01_T2w.nii.gz \
	-all -nuiterations 3 -T2pial -sd "$SUBJ_DIR" \
	-s sub-"$SUBJ_ID"_v2
