function [matlabbatch] = job_dicom_funct(s)

%change to current subjects directory
curdir = strcat(s.dataDir,s.funcRuns);
cd(curdir{1})
out{1} = curdir{1};

%extract the functional files for smoothing
funcfiles = dir('*.dcm'); %filter for the correct files
for k = 1:length(funcfiles)
    matlabbatch{1}.spm.util.import.dicom.data{k,1} = funcfiles(k).name;
end

%parameters
matlabbatch{1}.spm.util.import.dicom.root = 'flat';
matlabbatch{1}.spm.util.import.dicom.outdir = out;
matlabbatch{1}.spm.util.import.dicom.protfilter = '.*';
matlabbatch{1}.spm.util.import.dicom.convopts.format = 'nii';
matlabbatch{1}.spm.util.import.dicom.convopts.icedims = 0;

    
spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end