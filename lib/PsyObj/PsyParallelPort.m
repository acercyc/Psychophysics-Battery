classdef PsyParallelPort < handle
    properties
        ParaObj;
        LineObj;
    end
    
    methods
        function initial_out(obj)
            obj.ParaObj = digitalio('parallel','LPT1');
            obj.LineObj = addline(obj.ParaObj,0:7,0,'out');
            putvalue(obj.ParaObj,0);
        end
    end
end