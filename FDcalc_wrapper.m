%run FD_calc surface script in parallel
addpath(genpath('/projects/p32293/GrattonLab-General-Repo/motion_calc_utilities'))

subjects = {'LS02', 'LS03', 'LS05', 'LS08', 'LS11', 'LS14', 'LS16', 'LS17'};
datalist_dir = '/projects/p32293/datalists/';
parpool(str2num(getenv('SLURM_NPROCS')))

parfor s = 1:numel(subjects)
    datafile = sprintf('%s/%s_datalist.xlsx', datalist_dir, subjects{s});
    FDcalc_FMRIPREP(datafile)
    disp(['sub ' subjects{s} ' done'])
end
    