classdef PsyText < PsyDraw
% 1.0 - Acer 2011/06/07_14:57 
% 1.0.1 - Acer 2012/11/15 18:04
%         Modify drawCenter()
    
    properties
        Text = 'Test Words';
        textFont = 'Arial';
        textSize = 50;
        textStyle = 0; % 0=normal,1=bold,2=italic,4=underline,8=outline,32=condense,64=extend
        
        xy;
    end

    methods
        function obj = PsyText(winObj)
            obj = obj@PsyDraw(winObj);
        end
        
        function drawCenter(obj, text)
            if nargin == 2
                obj.Text = text;
            end            
            DrawFormattedText(obj.winObj.windowPtr, obj.Text,'center','center', obj.color);
        end
        
        function draw(obj) %#ok<*MANU>
        end
        
        function playCenter(obj, playWords)
            if nargin == 2
                obj.Text = playWords;
            end
            obj.drawCenter;
            obj.flip;            
        end
        
        function playWelcome(obj)
            obj.Text = 'Welcome to This Experiment';
            obj.playCenter;
        end
        
        function playRest(obj)
            obj.Text = 'Take a Break';
            obj.playCenter;
        end
        
        function playRest_Block(obj, blockNum)
            obj.Text = sprintf('Take a Rest\nRemain %d block(s)', blockNum);
            obj.playCenter;            
        end
    end

%% 'set' methods    
    methods
        function set.textFont(obj, value)
            obj.textFont = value;
            Screen('TextFont', obj.winObj.windowPtr, obj.textFont);
        end
        
        function set.textSize(obj, value)
            obj.textSize = value;
            Screen('TextSize', obj.winObj.windowPtr, obj.textSize); %#ok<*MCSUP>
        end
            
        function set.textStyle(obj, value)
            obj.textStyle = value;
            Screen('TextSize', obj.winObj.windowPtr, obj.textStyle);            
        end        
    end
end
