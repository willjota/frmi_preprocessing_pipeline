function [matlabbatch] = job_smooth(s)

%change to current subjects directory
curdir = [s.dataDir s.funcRuns{1}];
cd(curdir)

%extract the functional files for smoothing
funcfiles = dir('wraf*.nii'); %filter for the correct files
for k = 1:length(funcfiles)
    matlabbatch{1}.spm.spatial.smooth.data{k,1} = funcfiles(k).name;
end

%parameters
matlabbatch{1}.spm.spatial.smooth.fwhm = [5 5 5];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed_';


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end