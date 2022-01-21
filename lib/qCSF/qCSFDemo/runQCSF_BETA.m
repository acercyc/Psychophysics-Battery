function varargout = runQCSF_BETA(qcsf,varargin)
% 
% RUNQCSF   This program implements the critical trial-to-trial components of quick CSF method
% 
% For a qCSF application, the runQCSF program is used to call the subroutines that will 
% perform pre and post trial calculations, and plot the results of qCSF simulations and
% experiments. The calls to runQCSF_BETA are:
%       runQCSF_BETA(qcsf,'pretrial'); % Pre-trial analysis
%  
%       runQCSF_BETA(qcsf,'posttrial',response); % Update qCSF estimates
%                                                 based on the observer's response: 
%                                                 correct(response=1) 
%                                                 or incorrect(response=0) 
% 
%       runQCSF_BETA(qcsf,'plot experiment');     % Plots expt results 
%     
%
%
% For simulations: 
%
%      runQCSF_BETA(qcsf,'simulate'); % A weighted coin-flip is used to
%                                       simulate the observer's response
%  
%      runQCSF_BETA(qcsf,'plot simulation'); % Plots simulation results 
%    

% November 5, 2009             %fixed a bug for experimental applications
%                               

