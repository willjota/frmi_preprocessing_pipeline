function [s] = initialize_vars(subjects,i)

% SPM info
s.spmDir = fileparts(which('spm'));         % path to SPM installation

% Directory information
dataDir = '~/MATLAB/STUDY/subjects/'
s.curSubj = subjects{i};                    % current subject is the current one in the subject directory
s.dataDir = strcat(dataDir,s.curSubj,'/');  % make data directory subject-specific
s.funcRuns = {'run1','run2','run3'};        % folders containing functional images
s.anatT1 = 'T1';                            % folder containing T1 structural

end
