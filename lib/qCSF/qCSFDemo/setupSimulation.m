function qcsf = setupSimulation(qcsf,numTrials,varargin);
%SETUPSIMULATION sets up the model CSF for simulation.
%
%     setupSimulation(qcsf,numTrials,varargin)
% 
% 
%     This function setups up parameters of a quick CSF simulation.
%     The input variables are the qcsf structure, the number of trials desired 
%     for the simulation, and a third optional input -- a vector defining the 
%     simulated observer's model CSF: 
%
%      [peak-gain peak-frequency bandwidth low-frequency-truncation]. 
%
%     If this input variable is not provided, then a dialog box prompts the user 
%     to input the model CSF parameters.
% 
% Examples:
% 
% 	  qcsf = setupSimulation(qcsf,numTrials);
% 
%     qcsf = setupSimulation(qcsf,numTrials,[200 3 2.5 .25]);
% 
%     Copyright 2009 - Luis Andres Lesmes and Zhong-Lin Lu
%     Any reports of bugs, problems, or any comments or requests for additional features should
%     be sent to Lu Lesmes (lu@salk.edu).

if nargin>2
    simCSF=varargin{1};
else 
    prompt = {sprintf('%s\n%s','For the simulated observer,', 'enter the peak sensitivity (5-1000):'),...
        'enter the peak frequency (.25-10 cpd):',...
        'enter the bandwidth (1.5-6 octaves)',...
        'enter the low-frequency truncation (.05-1.5 log10 units)'};
    defaultanswer={'200','2.5','3','.6'};
    name = 'qCSF Simulation';
    demoInput=inputdlg(prompt,name,1,defaultanswer);

    for n=1:4,
        simCSF(n) = str2num(demoInput{n});
    end
end

qcsf.simulation.linearCSF=simCSF;
qcsf.simulation.trueCSF=log10(simCSF);
qcsf.simulation.trueSensitivity=findQCSF(log10(qcsf.stimuli.frequency),qcsf.simulation.trueCSF(1),qcsf.simulation.trueCSF(2),qcsf.simulation.trueCSF(3),qcsf.simulation.trueCSF(4)); 
qcsf.simulation.trials=numTrials;