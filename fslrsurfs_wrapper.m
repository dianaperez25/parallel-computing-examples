%run fsLR surface script in parallel

subjects = {'LS02', 'LS03', 'LS05', 'LS08', 'LS11', 'LS14', 'LS16', 'LS17'};
FSdata_dir = '/projects/b1081/Lifespan/Nifti/derivatives/freesurfer-6.0.1/';
cd /projects/b1081/Scripts/PostFreesurfer_Scripts
parpool(str2num(getenv('SLURM_NPROCS')))

parfor s = 1:numel(subjects)
    anat_dir = sprintf('/projects/b1081/Lifespan/Nifti/derivatives/preproc_fmriprep-20.2.0/fmriprep/sub-%s/anat/', subjects{s});
    PostFreeSurferPipeline_fsavg2fslr_long_GrattonLab_Updated(subjects{s}, FSdata_dir, anat_dir)
    disp(['sub ' subjects{s} ' done'])
end
    