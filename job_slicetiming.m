function [matlabbatch] = job_slicetiming(s)

%change to current subjects directory
curdir = [s.dataDir s.funcRuns{1}];
cd(curdir)

%extract the functional files for this subject to do slice time correction
funcfiles = dir('f*.nii');
for k = 1:length(funcfiles)
    scans{k} = strcat(curdir,funcfiles(k).name);
end
scans = scans'; 

%input each of these scans into STC matlabbatch structure
for j = 1:length(scans)
    matlabbatch{1}.spm.temporal.st.scans{j,1} = scans(j);
end

%set parameters for slice timinging
matlabbatch{1}.spm.temporal.st.nslices = 58;
matlabbatch{1}.spm.temporal.st.tr = 2;
matlabbatch{1}.spm.temporal.st.ta = (2-(2/58));
matlabbatch{1}.spm.temporal.st.so = [[1,30],[3,32],[5,34],[7,36],[9,38],[11,40],[13,42],[15,44],[17,46],[19,48],[21,50],[23,52],[25,54],[27,56],[29,58],[2,31],[4,33],[6,35],[8,37],[10,39],[12,41],[14,43],[16,45],[18,47],[20,49],[22,51],[24,53],[26,55],[28,57]];
matlabbatch{1}.spm.temporal.st.refslice = 29;
matlabbatch{1}.spm.temporal.st.prefix = 'a';

spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end