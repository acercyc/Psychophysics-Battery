function qcsf = setupQCSF
%SETUPQCSF Initializes the quick CSF's structure variable: 
% 
%   qcsf = 
%     stimuli: [1x1 struct]
%     parameters: [1x1 struct]
%
%
% setupQCSF.m sets up the CSF parameter space and grating stimulus space that
% underlie the qCSF method.
% Most of the experimental variables initialized in the setupQCSF.m program are 
% hardware dependent: (1) the range and resolution of grating contrasts
% depend on your monitor's grayscale properties and (2) the range of
% spatial frequencies depends on monitor resolution and viewing
% distance. For that reason, we provide hardcoding of these experimental
% properties, which is only called one time at the start
% of the experiments.
% 
% 
% 
% Copyright 2009 - Luis Andres Lesmes and Zhong-Lin Lu
% Any reports of bugs, problems, or any comments or requests for additional features should
% be sent to Lu Lesmes (lu@salk.edu).


%%%%%%%%%%%%%%%%%% Setting up the quick CSF stimulus space  %%%%%%%%%%%%%%%%%%%%
contrastLevels = 60;    
frequencyLevels = 16;
% the sampling levels for the 2-D space of grating frequency and contrast

% As a default, the minimum contrast level is 1/10 percent and the max is 100 percent.
% Sampling this range with 1 dB resolution results in 60 possible test contrasts.

minContrast = .001;    % min and max values for grating contrast
maxContrast = 1;

minFrequency=.25;      % min and max values for grating frequency
maxFrequency=36;

gratingContrast = 10.^linspace(log10(minContrast),log10(maxContrast),contrastLevels)';
gratingFrequency = 10.^linspace(log10(minFrequency),log10(maxFrequency),frequencyLevels)';

qcsf.stimuli.contrast = gratingContrast;
qcsf.stimuli.frequency = gratingFrequency;

[stimFrequency,stimContrast] = meshgrid(gratingFrequency,gratingContrast);

qcsf.stimuli.conditions=[(stimFrequency(:)) (stimContrast(:))]; % this is a list of the stimulus conditions
                                                                % passed to the pre-trial analysis, the stimulus
                                                                % search algorithm picks a grating frequency and contrast 
                                                                % from this list for the next trial.

%%%%%%%%%%%%%%%%%% Setting up the quick CSF parameter space  %%%%%%%%%%%%%%%%%%%%

csfParam = [29 28 27 26]; 

% The ranges for each dimension of the gridded parameter space
% are defined below. The above csfParam variable defines the number of elements, and in turn
% the sampling resolution, along those ranges. The maximum allowed values
% for the sampling resolution of the parameter space is dependendent on your 
% computer's memory capabilities.


qcsf.parameters.gain=linspace(log10(2),log10(2000),csfParam(1));
qcsf.parameters.center= linspace(log10(.2),log10(20),csfParam(2));
qcsf.parameters.width = linspace(log10(1),log10(9),csfParam(3));
qcsf.parameters.trunc = linspace(log10(.02),log10(2),csfParam(4));