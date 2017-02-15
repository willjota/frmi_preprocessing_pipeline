function [matlabbatch] = job_normalise(s)

%change to current subjects directory
curdir = [s.dataDir s.funcRuns{1}];
cd(curdir)

%get deformation image
strucdir = [s.dataDir s.anatT1];
d = dir('y_*.nii');
copyfile(strcat(strucdir,'/',d.name), curdir); %filter for the correct files
dimg{1} = d.name;
matlabbatch{1}.spm.spatial.normalise.write.subj.def = dimg;


%extract the functional files for resampling
funcfiles = dir('raf*.nii'); %filter for the correct files
for k = 1:length(funcfiles)
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample{k,1} = funcfiles(k).name;
end

%parameters
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78, -112,-70;78,76,85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2,2,2];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end