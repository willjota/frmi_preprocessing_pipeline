function [matlabbatch] = job_imcalc(s)

%change to current subjects directory
curdir = [s.dataDir s.anatT1];
cd(curdir)
out{1} = curdir;

%extract the functional files for this subject to do slice time correction
img{1,1} = dir('c1*.nii'); %GM
img{1,2} = dir('c2*.nii'); %WM
img{1,3} = dir('c3*.nii'); %CSF
img{1,4} = dir('ms*.nii'); %bias correction

input{1,1} = img{1,1}.name;
input{1,2} = img{1,2}.name;
input{1,3} = img{1,3}.name;
input{1,4} = img{1,4}.name;

%parameters
matlabbatch{1}.spm.util.imcalc.input(1,1) = input(1,1);
matlabbatch{1}.spm.util.imcalc.input(1,2) = input(1,2);
matlabbatch{1}.spm.util.imcalc.input(1,3) = input(1,3);
matlabbatch{1}.spm.util.imcalc.input(1,4) = input(1,4);

matlabbatch{1}.spm.util.imcalc.output = 'Brain';
matlabbatch{1}.spm.util.imcalc.expression = '(i1 + i2 + i3) .* i4';
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;


spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

end