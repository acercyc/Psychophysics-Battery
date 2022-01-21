classdef PsyOval < PsyDraw
%======================================================================%
% Modified by Acer 2013/02/13 15:48
%======================================================================%
    
    properties
        ObjSize = [30 30];
        xy;
        OvalCenter;
    end
    
    properties (Hidden = true, Access = private)
        setFlag = 0;
    end
    
    
    
%% Constructor
    methods
        function obj = PsyOval(winObj)
            obj = obj@PsyDraw(winObj);
            obj.OvalCenter = [winObj.xcenter winObj.ycenter];
            obj.xySet;            
        end
        
%% Function function
        function draw(obj)
            Screen('FillOval', obj.winObj.windowPtr, obj.color, obj.xy);
        end
    end

%% 'Set' functions
    methods 
        function set.OvalCenter(obj,value)
            if numel(value) ~= 2
                error('OvalCenter input error');
            end
            obj.OvalCenter = value;
            if obj.setFlag == 0 %#ok<*MCSUP>
                obj.setFlag = 1;
                xySet(obj);     
                obj.setFlag = 0;
            end
        end
        
        function set.ObjSize(obj, value)
            if numel(value) ~= 2
                error('ObjSize input error');
            end            
            obj.ObjSize = value;
            if obj.setFlag == 0 %#ok<*MCSUP>
                obj.setFlag = 1;
                xySet(obj);     
                obj.setFlag = 0;
            end
        end   
        
        function set.xy(obj, value)
            if numel(value) ~= 4
                error('xy input error');
            end            
            obj.xy = value;
            if obj.setFlag == 0 %#ok<*MCSUP>
                obj.setFlag = 1;
                obj.OvalCenter = [mean(value([1 3])), mean(value([2 4]))];
                obj.ObjSize = [(value(3) - value(1)), (value(4) - value(2))];
                obj.setFlag = 0;
            end
        end           
    end
    
%% Private function
    methods (Hidden = true, Access = private)
        function xySet(obj)
            obj.xy = [(obj.OvalCenter(1) - obj.ObjSize(1)/2), ...
                      (obj.OvalCenter(2) - obj.ObjSize(2)/2), ...
                      (obj.OvalCenter(1) + obj.ObjSize(1)/2), ...
                      (obj.OvalCenter(2) + obj.ObjSize(2)/2)];     
        end
    end
end