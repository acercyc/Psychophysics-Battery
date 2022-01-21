classdef PsyRect < PsyDraw
    properties
        xy = [winObj.xcenter - 50, winObj.ycenter-30, winObj.xcenter + 50, winObj.ycenter+ 30];
    end
    
    
    methods
        function obj = PsyRect(winObj)
            obj = obj@PsyDraw(winObj);
        end
        
        function draw(obj)
            Screen(obj.winObj.windowPtr,'FillRect', obj.color, obj.xy);
        end
        
        function blank(obj)
            Screen(obj.winObj.windowPtr,'FillRect', obj.winObj.backgroundColor);
        end
        
        function playBlank(obj)
            obj.blank;
            obj.flip;
        end
    end
end