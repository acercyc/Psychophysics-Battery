function [selection, taskAbbv, taskIndex] = practice_taskSelectionGUI()
%======================================================================%
% 1.0 - Acer 2013/02/16 10:52
%======================================================================%
    
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
respOrder = inputdlg({'Response Order (1 or 0)'}, 'Enter Order', 1, {'1'});
respOrder = respOrder{1}; 

paraFilename = sprintf('para_practice_ord_%s.mat', respOrder);

commandwindow();
if strcmp(selection, 'Colour Luminance Adjust Test')
    colourLumAdjTask(paraFilename)
elseif strcmp(selection, 'qCSF Test')
    main_qCSF(paraFilename);
else
    main(paraFilename, taskAbbv, selection);
end
    
