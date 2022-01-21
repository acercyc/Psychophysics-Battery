classdef PsyPresent < handle 
% 1.0 - Acer 2011/06/03_17:37

    properties
        startTime;
        endTime;
        duration = 1;
        timingRec;   
    end    
    
    methods (Abstract = true)
        play(obj);
    end
    
end