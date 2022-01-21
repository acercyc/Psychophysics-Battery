classdef PsyInitialize < handle
    
% Initialization
% 1.0 - Acer 2010/7/27
% 1.1 - Acer 2011/05/27_14:00
% 1.2 - Acer 2011/06/03_14:34

    properties 
        % envirSetting
        SkipSyncTests = 0;
        VisualDebugLevel = 3;
        SuppressAllWarnings = 1;
        
        oldVisualDebugLevel;
        oldSupressAllWarnings;
    end
    
    methods        
        function obj = PsyInitialize
            envirSet(obj);
        end
    end
    
    methods %(Static) may write this as a Static finction in the future
        function envirSet(obj)
            AssertOpenGL;
            obj.oldVisualDebugLevel = Screen('Preference','VisualDebugLevel', obj.VisualDebugLevel);
            obj.oldSupressAllWarnings = Screen('Preference','SuppressAllWarnings', obj.SuppressAllWarnings);
            Screen('Preference', 'SkipSyncTests', obj.SkipSyncTests);         
        end
        
        function envirSetByManual(obj)
            % Setting for 
            % VisualDebugLevel
            % SuppressAllWarnings /
            % SkipSyncTests/ 
            % the second argument is for GUI input (ByManual == 1)
            % 1.0 - Acer 2010/7/27
            
            % GUI input
            PromptCell{1} = 'VisualDebugLevel (0~5)';
            PromptCell{2} = 'SuppressAllWarnings (0/1)';
            PromptCell{3} = 'SkipSyncTests (0/1)';

            defCell{1} = num2str(obj.VisualDebugLevel);
            defCell{2} = num2str(obj.SuppressAllWarnings);
            defCell{3} = num2str(obj.SkipSyncTests);

            SetFlag = inputdlg(PromptCell, 'Environment Settings', 1, defCell);

            obj.VisualDebugLevel = str2num(SetFlag{1});
            obj.SuppressAllWarnings = str2num(SetFlag{2});
            obj.SkipSyncTests = str2num(SetFlag{3});
  
            envirSet(obj);
        end
    end
end