function [selection, taskAbbv, taskIndex] = taskSelectionGUI()
%======================================================================%
% 1.0 - Acer 2013/02/16 10:52
% 1.1 - Acer 2013/11/06 11:26
%       Add:
%         'Glass Pattern Test'
%         'Temporal Order Judgment Test'
%         'qCSF Test'
% 1.2 - Acer 2013/12/06
%       Start use UnifyKeyNames
%======================================================================%
addpath( genpath('lib') );
KbName('UnifyKeyNames');
disp('Lib imported');


%---------------------------------------------------------------------%
% GUI
%---------------------------------------------------------------------%
task = {'Motion Coherence Test',...
        'Colour Sensitivity Test',...
        'Luminance Sensitivity Test',...
        'Shape Sensitivity Test',...
        'Colour Luminance Adjust Test'...
        'Glass Pattern Test'...
        'Temporal Order Judgment Test'...
        'qCSF Test'...
        };
[taskIndex, ok] = listdlg('ListString', task, 'SelectionMode', 'single');     






%---------------------------------------------------------------------%
% Task selection
%---------------------------------------------------------------------%
if ok                

    selection = task{taskIndex};

    switch selection
        case 'Motion Coherence Test'
            taskAbbv = 'motion';
        case 'Colour Sensitivity Test'
            taskAbbv = 'colour';
        case 'Luminance Sensitivity Test'
            taskAbbv = 'luminance';
        case 'Shape Sensitivity Test'
            taskAbbv = 'shape';
        case 'Colour Luminance Adjust Test'
            taskAbbv = 'claTest';
        case 'Glass Pattern Test'
            taskAbbv = 'GlassTest';
        case 'Temporal Order Judgment Test'
            taskAbbv = 'TOJ';             
        case 'qCSF Test'
            taskAbbv = 'qCSF';               
    end


else
    error('Experiment Abort');
end
    


%----------------------------------------------------------------------%
% Execute Program
%----------------------------------------------------------------------%
subjectID = '';
load('lib\GUI\subjectIDpromt.mat');
subjectID = inputdlg({'Subject ID'}, 'Enter Subject ID', 1, {subjectID});
subjectID = subjectID{1}; 
save('lib\GUI\subjectIDpromt.mat', 'subjectID');

paraFilename = sprintf('para_%s', subjectID);

% commandwindow();
if strcmp(selection, 'Colour Luminance Adjust Test')
    colourLumAdjTask(paraFilename);
elseif strcmp(selection, 'qCSF Test')
    main_qCSF(paraFilename);
else
    main(paraFilename, taskAbbv, selection);
end

    
