classdef PsyDraw < handle
% 1.1 - Acer 2011/06/03_15:04
% 1.2 - Acer 2012/10/25 15:14
%   Delete timing function 
% 1.3 - Acer 2012/11/29 00:40
%   Return flip time
% 1.4 - Acer 2013/03/05 10:49
%   Return flip time for .play()
    properties
        % Present to window
        winObj;
        
        % attribute
        color = [200 200 200];
        flipTime;        
        % time

    end
    
    properties (Abstract = true)
        xy;
    end

    methods
        function obj = PsyDraw(winObj)
            obj.winObj = winObj;
        end
    
        function flipTime = play(obj)
            obj.draw;
            flipTime = obj.flip;
        end
        
        function flipTime = flip(obj)
            flipTime = Screen(obj.winObj.windowPtr,'Flip');
            obj.flipTime = flipTime;
            QuitPsych;
        end        
    end
    
    methods (Abstract)
        draw(obj);
    end     
end
