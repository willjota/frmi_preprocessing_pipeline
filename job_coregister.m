function [matlabbatch] = job_coregister(s)

%change to current subjects directory
curdir = [s.dataDir s.funcRuns{1}];
cd(curdir)

%get reference image
strucdir = [s.dataDir s.anatT1];
copyfile(strcat(strucdir,'/Brain.nii'), curdir); %filter for the correct files
refimg{1} = 'Brain.nii';
matlabbatch{1}.spm.spatial.coreg.estimate.ref(1) = refimg;

%get source image
simg = dir('meanaf*.nii');
sourceimg{1} = simg(1).name;
matlabbatch{1}.spm.spatial.coreg.estimate.source(1) = sourceimg;

%extract the functional files for coregistration
funcfiles = dir('raf*.nii'); %filter for the correct files
for k = 1:length(funcfiles)
    matlabbatch{1}.spm.spatial.coreg.estimate.other{k,1} = funcfiles(k).name;
end

%parameters
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4,2];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7,7];

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end