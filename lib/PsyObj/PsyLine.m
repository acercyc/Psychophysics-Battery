classdef PsyLine < PsyDraw
    properties
        Width = 1;
        xy = [winObj.xcenter - 30, winObj.ycenter, winObj.xcenter + 30, winObj.ycenter]; 
    end


    methods
        function obj = PsyLine(winObj)
            obj = obj@PsyDraw(winObj);
        end
        
        function draw(obj)
            Screen('DrawLine', obj.winObj.windowPtr, obj.color, obj.xy(1), obj.xy(2), obj.xy(3), obj.xy(4), obj.Width);
        end
    end
end
