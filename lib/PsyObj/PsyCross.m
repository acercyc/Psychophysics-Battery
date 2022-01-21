classdef PsyCross < PsyDraw
% 2.0 - Acer 2011/06/13_15:04
    
    properties
        size = 30;
        width = 3;
        xy = [];
    end

    methods
        function obj = PsyCross(winObj)
            obj = obj@PsyDraw(winObj);
            obj.xy = [winObj.xcenter winObj.ycenter];
        end
        
        function draw(obj)
            Screen('DrawLine',obj.winObj.windowPtr , obj.color, obj.xy(1) - obj.size/2, obj.xy(2), obj.xy(1)+ obj.size/2, obj.xy(2), obj.width);
            Screen('DrawLine',obj.winObj.windowPtr , obj.color, obj.xy(1), obj.xy(2) - obj.size/2, obj.xy(1), obj.xy(2) + obj.size/2, obj.width);
        end
    end
end
