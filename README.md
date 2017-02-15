# frmi_preprocessing_pipeline

This is a pipeline to easily preprocess fMRI data using SPM functions and software.

Statistical Parametric Mapping (SPM; http://www.fil.ion.ucl.ac.uk/spm/) is a standard fMRI analysis toolbox for Matlab. However, it is often difficult to automate the preprocessing across several subjects. This pipeline utilizes built in SPM functions to automate this process. 

First you will need to download MATLAB and SPM toolbox for your machine. These code are written as Matlab functions that call SPM functions. 

First, set up your directories in the main_batch.m file. The current structure of a directory that this reads form is ~/STUDYNAME/subjects/, where it can iterate through all of the subject subdirectories in the parent subjects directory.

Second, select which jobs you want to run on your files. A list of the jobs are listed in the commented out section. These are the standard preprocessing jobs recommended in SPM 12. Subsequently, all of the preprocessing parameters need to be changed in each of the job files to fit the study's specified criteria. 

Third, change variable_intializaiton parameters to appropriate directories where the functional runs and the structural data can be found. 

When all parameters and directories are set, you will just run the main_batch.m file. Some SPM windows may automatically open during preprocessing. Any errors will be output to an error log. You can also monitor preprocssing through the main matlab window where SPM output should be printed.

This pipeline has been altered from previously publically available code and adapated to the most current SPM12 functions and parameter settings.
