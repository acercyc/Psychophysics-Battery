function subjInfo = paraMakerGUI(subjectID)
%======================================================================%
% Generate Parameters 
% 1.0 - Acer 2012/11/19 15:19
% 2.0 - Acer 2013/02/14 13:35
%======================================================================%

    addpath(genpath('lib'));
    disp('PsyObj imported');
    % ----------------------------------- Acer - 2013/02/14 13:38


    if ~exist('subjectID', 'var')
        subjectID = 's999';
    end
    
    
    
    sInputPrompt = {'subjectID',...
                    'subjectName', ...
                    'Gender ( m / f )',...
                    'Age',...
                    'Handedness ( r / l )',...
                    'Response Order (1 or 0)'
                   };
    sInputDefAns = {subjectID,...
                    'Acer',...
                    'm',...
                    '28',...
                    'r',...
                    '1'
                   };
    sInputAnswer = inputdlg(sInputPrompt, 'sInfo', 1, sInputDefAns); 

    
    
    
    subjInfo = cell2struct(sInputAnswer,...
                                {'ID', 'Name', 'gender', 'age', 'handedness', 'respOrder'},...
                                1);

                            
                            
                            
    paraObj(subjInfo);
    
    
    
end



