# frmi_preprocessing_pipeline

This is a pipeline to easily preprocess fMRI data using SPM functions and software.

Statistical Parametric Mapping (SPM; http://www.fil.ion.ucl.ac.uk/spm/) is a standard fMRI analysis toolbox for Matlab. However, it is often difficult to automate the preprocessing across several subjects. This pipeline utilizes built in SPM functions to automate this process. 

First you will need to download MATLAB and SPM toolbox for your machine. These code are written as Matlab functions that call SPM functions. You will just need to set up your directories in intialize variables and make sure you edit all parameters in the 'job_*.m' files. 

