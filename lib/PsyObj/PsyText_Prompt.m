classdef PsyText_Prompt < PsyText & PsyResp
% 1.0 - Acer 2011/06/23_03:13
% 2.0 - Acer 2012/11/22 08:01
%       Change the name from PsyText_meg to PsyText_Prompt
% 2.0.1 - Acer 2013/11/14 17:16
%         add checkAndPlayInstruction_imgfile

    properties
    end
    
    methods
        function obj = PsyText_Prompt(winObj)
            obj = obj@PsyText(winObj);
        end        
        
        function playWelcome(obj)
            obj.Text = sprintf('Welcome to this experiment\n\nPress SPACE to start');
            obj.playCenter;
            obj.allowKey = 'space';
            obj.waitPress();
            obj.flip();            
        end
        
        function playRest_Block_wait(obj, blockNum)
            obj.Text = sprintf('Remain %d block(s)\n\nPlease wait', blockNum);
            obj.playCenter; 
        end
        
        function playRest_Block_pressKey(obj, blockNum)
            obj.Text = sprintf('Remain %d block(s)\n\nPress the buttom to start', blockNum);
            obj.playCenter; 
        end
        
        function playRest_CountDown(obj, sec)
            t1 = GetSecs();
            while GetSecs() - t1 < sec
                obj.Text = sprintf('Take a break. Please wait.\n\n%d', sec - ceil(GetSecs() - t1) + 1);
                obj.playCenter;
            end
            obj.Text = 'Press SPACE to continue';
            obj.playCenter;
            obj.allowKey = 'space';
            obj.waitPress();
            obj.flip();
        end
        
        function playInstruction_imgfile(obj, file)
        % 1.0 - Acer 2013/11/11 12:56
            p = PsyPic(obj.winObj);
            p.read(file);
            p.targetSize = fitImageSize(p.origSize, obj.winObj.windowRect(3:4));
            p.play();
            obj.allowKey = 'space';
            obj.waitPress();
            obj.flip();
            WaitSecs(5);
        end
        
        
        function checkAndPlayInstruction_imgfile(obj, taskAbbv)
        % 1.0 - Acer 2013/11/14 14:21
            insFileName = sprintf('instructionsForSubjs/%s.PNG', taskAbbv);
            if exist(insFileName, 'file');
                p = PsyPic(obj.winObj);
                p.read(insFileName);
                p.targetSize = fitImageSize(p.origSize, obj.winObj.windowRect(3:4));
                p.play();
                obj.allowKey = 'space';
                obj.waitPress();
                obj.flip();
                WaitSecs(3);
            end
        end        
        
        
    end
end