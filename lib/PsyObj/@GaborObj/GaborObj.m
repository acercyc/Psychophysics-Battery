%======================================================================%
% 1.0 - Acer 2013/10/19 12:15
% 2.0 - Acer 2013/11/06 15:28
%       Change the sigma to be a dependent property 
%======================================================================%
classdef GaborObj < handle

    properties
        
        % Gabor Parameters
        s = 1;
        resolution = 500;
        f = 4;
        theta = 0;        
        phase = 0;
        L0 = 0.5;
        c = 1;
        xGamma = 1;
        yGamma = 1;
        
        sigmaCoverage = 0.9999;
        
        
        % Obj contents
        img = [];
        
    end
    
    
    
    
    properties (Dependent = true)
        sigma
    end
    
    
    
    
    methods
        
        
        function obj = GaborObj()
        end
        
        
        function v = makeGabor(obj)  
            v = obj.gabor_basic(obj.s, ...
                                obj.resolution, ...
                                obj.f, ...
                                obj.theta, ...
                                obj.sigma, ...
                                obj.phase, ...
                                obj.L0, ...
                                obj.c, ...
                                obj.xGamma, ...
                                obj.yGamma);         
        end
        
        
        
        % function v = makeGabor_VisualAngle(obj)
        % % 1.0 - Acer 2013/10/19 12:24            
        % end
        
        
        
        function show(obj)
        % 1.0 - Acer 2013/10/19 12:24
            v = obj.makeGabor;
            imshow(v);
            axis equal
        end
        
        
        
        
        function v = get.sigma(obj)
            v = obj.s / norminv(obj.sigmaCoverage, 0, 1) / 2;
        end
        
        
        
        
    end
    
    
    
    
    
    
    
    methods (Static)
        v = gabor_basic(s, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma) 
        v = gabor_by_VisualAngle(angle, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma)
    end
    
    
    
    
end

