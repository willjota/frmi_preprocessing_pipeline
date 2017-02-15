function [matlabbatch] = job_realign(s)

%change to current subjects directory
curdir = [s.dataDir s.funcRuns{1}];
cd(curdir)

%extract the functional files for this subject to do slice time correction
funcfiles = dir('af*.nii'); %filter for the correct files
for k = 1:length(funcfiles)
    scans{k} = funcfiles(k).name;
end
scans = scans'; 

%input each of these scans into STC matlabbatch structure
for j = 1:length(scans)
    matlabbatch{1}.spm.spatial.realign.estwrite.data{1}(j) = scans(j);
end

%parameters
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';

matlabbatch{1}.spm.spatial.realign.estwrite.roption.which = [0 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end