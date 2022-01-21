% 1.0 - Acer 2011/08/28_12:13

classdef PsyDots < PsyDraw
    properties
        dotSize = 6;
        xy;
        dotType = 1; % 1:circle; 0:squire
        allCenter
    end    
    
%% Constructor
    methods
        function obj = PsyDots(winObj)
            obj = obj@PsyDraw(winObj);
            obj.allCenter = [winObj.xcenter winObj.ycenter];
            Screen('BlendFunction', obj.winObj.windowPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        end
        
%% Function function
        function draw(obj)
            Screen('DrawDots', obj.winObj.windowPtr, obj.xy, obj.dotSize, obj.color, obj. allCenter, obj.dotType);
        end
    end
end