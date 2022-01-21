classdef tojObj 
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        para = []
        center = [];
        
        
        targetObj = [];
        winObj = [];
        
        fixObj = [];
        fixObjDura = 0.5;
        
    end
    
    
    
    methods
        function obj = tojObj(w, para)
            obj.para = para;
            obj.winObj = w;
            obj.targetObj = PsyOval(w);
            obj.targetObj.color = para.colour;
            obj.targetObj.ObjSize = [para.size para.size];
            obj.center(1, :) = obj.targetObj.OvalCenter - [para.ecentDist 0];
            obj.center(2, :) = obj.targetObj.OvalCenter + [para.ecentDist 0];              
            
            obj.fixObj = PsyCross(w);
        end
        
        
        function play(obj, ifOneFirst,t)
            if ifOneFirst
                iFirst = 1;
                iSecond = 2;
            else
                iFirst = 2;
                iSecond = 1;
            end
            
            % Fixation 
%             obj.fixObj.play();
%             WaitSecs(obj.fixObjDura);
            
            
            % Present the first stimulus
            obj.fixObj.draw();
            obj.targetObj.OvalCenter = obj.center(iFirst, :);
            t0 = obj.targetObj.play();
            
            
            % Prepare for the second stimulus
            obj.fixObj.draw();
            obj.targetObj.draw();
            obj.targetObj.OvalCenter = obj.center(iSecond, :);
            obj.targetObj.draw();
            
            
            
            while GetSecs() - t0 < t
            end
%             fprintf('dura = %.6f\n', GetSecs() - t0);
            
            % Present the second stimulus
            t1 = obj.winObj.flip();
            
            % Total duration
            while GetSecs() - t0 < obj.para.totalDuration
            end            
            
            obj.winObj.flip();
            
            
            fprintf('Read SOA = %.6f\n', t1 - t0);
            
        end
        
        
        
        
    end
    
end

