function subjInfo = practice_paraMakerGUI
%======================================================================%
% Generate Parameters 
% 1.0 - Acer 2012/11/19 15:19
% 2.0 - Acer 2013/02/14 13:35
%======================================================================%

    addpath(genpath('lib'));
    disp('PsyObj imported');
    % ----------------------------------- Acer - 2013/02/14 13:38

    

%----------------------------------------------------------------------%
% Response Order 1
%----------------------------------------------------------------------%  
    sInputDefAns = {'practice_ord_1',...
                    'practice',...
                    'm',...
                    '999',...
                    'r',...
                    '1'
                   };
               
    subjInfo = cell2struct(sInputDefAns,...
                                {'ID', 'Name', 'gender', 'age', 'handedness', 'respOrder'},...
                                2);                            
                            
    practice_paraObj(subjInfo);
    
    
    
    
%----------------------------------------------------------------------%
% Response Order 0
%----------------------------------------------------------------------%
    sInputDefAns = {'practice_ord_0',...
                    'practice',...
                    'm',...
                    '999',...
                    'r',...
                    '0'
                   };    
               
    subjInfo = cell2struct(sInputDefAns,...
                                {'ID', 'Name', 'gender', 'age', 'handedness', 'respOrder'},...
                                2); 
    practice_paraObj(subjInfo);                            

    
end



