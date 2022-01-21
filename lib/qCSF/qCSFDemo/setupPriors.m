function qcsf = setupPriors(qcsf,varargin)
%SETUPPRIORS sets up the intial prior for quick CSF method
%   qcsf = setupPriors(qcsf,varargin)
% 
% The initial probability density defined over the 4-D CSF parameter space
% reflects knowledge about CSF parameters before the experiment starts.
% If you do not want to use the dialog box to enter the prior modes (the
% best guesses for CSF parameters), you can pass a vector with the
% parameter values for the modes of the 1-D marginals for each parameter.
%
%
% The following routines translate the CSF parameter guesses (and their confidences) 
% into a 4-D prior, which is the normalized product of the 1-D marginals.
% For each parameter, the 1-D marginal prior is modeled by a 
% hyperbolic secant functions of the form:  
%  
%
%  p(parameter) = sech(fitWeight*(paramVector-paramGuess));
%
%
% Copyright 2009 - Luis Andres Lesmes and Zhong-Lin Lu
% Any reports of bugs, problems, or any comments or requests for additional features should
% be sent to Lu Lesmes (lu@salk.edu).

if nargin==2
    priorModes=log10(varargin{1});
else    
    prompt = {sprintf('%s\n%s','For the quick CSF initial priors,', 'enter the best guess for peak sensitivity (5-1000):'),...
        'Enter the best guess for peak frequency (.5-10 cpd):',...
        'Enter the best guess for bandwidth (1.5-6 octaves)',...
        'Enter the best guess for low-frequency truncation (.05-1.5 log10 units)'};
    defaultanswer={'100','2','3','.33'};
    name = 'CSF Priors';
    demoInput=inputdlg(prompt,name,1,defaultanswer);

    for n=1:4,
        priorModes(n) = log10(str2num(demoInput{n}));
    end
end

% The rest of the code generates a 4-D initial prior defined over the CSF
% parameter space, given the values for the marginal prior modes provided in the priorModes
% variable. 

gainGuess=priorModes(1);  % Values used priorModes vector is translated to the 
centerGuess=priorModes(2); % peaks of marg
widthGuess=priorModes(3);
truncGuess=priorModes(4);

% To make it easy to generate priors for the qCSF method, we define confidence 
% in initial CSF parameter estimates on 
% a scale from 0 to 1. For each parameter, confidence=0 corresponds to the situation in which
% the initial marginal prior is flat, and confidence = 1 corresponds to when the prior=1.0
% for one CSF parameter value and 0 otherwise. Because these scenarios also
% define the maximum and minimum marginal entropies, -sum(p*log(p)), 
% we can naturally connect this confidence scale to an entropy scale. 

% This is what the rest of the code does.
% Based on a confidence rating from 0 to 1 for each parameter, the
% hyperbolic secant function is used to generate a function with
% an entropy scaled to amount of information gain possible (from 0 to 100%)
% in the given CSF parameter space.


gainConfidence = .1;  
centerConfidence =.1;
widthConfidence =.1;
truncConfidence =.1;

% For the moment, before much normative data has been collected with the qCSF, we suggest
% hard-coding the confidence of each CSF parameter estimate with relatively
% low confidence. This may change with more collection of qCSF data over a wide range of normal and abnormal
% vision, but it's prudent for now.


sechGuess = 2; % this is just to seed the search for the proper fit weight.

%  prior = sech(fitWeight*(paramVector-paramGuess));

gainWeight=fminsearch('fitSechCost',sechGuess,[],qcsf.parameters.gain,gainGuess,gainConfidence);
centerWeight=fminsearch('fitSechCost',sechGuess,[],qcsf.parameters.center,centerGuess,centerConfidence);
widthWeight=fminsearch('fitSechCost',sechGuess,[],qcsf.parameters.width,widthGuess,widthConfidence);
truncWeight=fminsearch('fitSechCost',sechGuess,[],qcsf.parameters.trunc,truncGuess,truncConfidence);

[ESTG,ESTC,ESTW,ESTT] = ndgrid(qcsf.parameters.gain,qcsf.parameters.center,qcsf.parameters.width,qcsf.parameters.trunc);
    
prior = sech(gainWeight*(ESTG-gainGuess)).* ...
            sech(centerWeight*(ESTC-centerGuess)).*...
            sech(widthWeight*((ESTW)-widthGuess)).*...
            sech(truncWeight*(ESTT-truncGuess));
          
prior = prior./sum(prior(:));

gain_hat = qcsf.parameters.gain*marginalize(prior,[2 3 4]); 
center_hat = qcsf.parameters.center*marginalize(prior,[1 3 4])'; 
width_hat = qcsf.parameters.width*marginalize(prior,[1 2 4]);      
trunc_hat = qcsf.parameters.trunc*marginalize(prior,[1 2 3]); 

qcsf.data.prior = prior;
qcsf.data.prior0 = prior;

qCSF.data.priorCSF = [gain_hat center_hat width_hat trunc_hat];
qCSF.data.priorSensitivity= findQCSF(qcsf.stimuli.frequency,gain_hat,center_hat,width_hat,trunc_hat);
