clear all;

% get and set paths
scriptdir = pwd;
addpath('~/MATLAB/preproc_pipeline/'); % add any necessary paths

%extract subject names for multiple subject preprocessing
subjdirs = '~/Documents/MATLAB/STUDY/subjects/';
pattern = fullfile(subjdirs,'s*');
subjs = dir(pattern);
for k = 1:length(subjs)
    subjects{1,k} = subjs(k).name;
end


% Specify variables
outLabel = 'preproc'; %output label

batch_functions = {'job_slicetiming'};


% %jobs: 'job_dicom_anat','job_dicom_funct','job_slicetiming',...
%     'job_realign','job_segment','job_imcalc','job_coregister',...
%     'job_normalise','job_smooth'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize error log
errorlog = {}; ctr=1;

% loop over batch functions
for m=1:length(batch_functions)
    fprintf('\nFunction: %s\n',batch_functions{m});

    % loop over subjects
    for i=1:length(subjects)
        fprintf('\nWorking on %s...\n',subjects{i});

        % get subject-specific variables
        s = initialize_vars(subjects,i);

        % move to subject data folder
        cd(s.dataDir);

        %run matlabbatch job
        try

            %run current job function, passing along subject-specific inputs
            batch_output = eval(strcat(batch_functions{m},'(s)'));

            %save output (e.g., matlabbatch) for future reference
            outName = strcat(outLabel,'_',date,'_',batch_functions{m});
            save(outName, 'batch_output');

        catch err % if there's an error, take notes & move on
            errorlog{ctr,1} = subjects{i};
            errorlog{ctr,2} = batch_functions{m};
            errorlog{ctr,3} = err;
            ctr = ctr + 1;
            cd(scriptdir);
            continue;
        end

        cd(scriptdir);
    end

end

if ~isempty(errorlog)
    disp(errorlog) % print error log at end
else
    disp('No errors detected.');
end