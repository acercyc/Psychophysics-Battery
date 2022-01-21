classdef VisualAngleCalculator < handle
%======================================================================%
% 1.0 - Acer 2013/10/10 22:04
%======================================================================%
    
    
    properties
        angle = 2                   % degree
        distance = 100              % cm
        screenDiagonal = 19 * 2.54  % cm
        resolutionW = 1024          % pixel 
        resolutionH = 768           % pixel 
        stiPixel = 100              % pixel 
 
    end
    
    
    
    methods
        
        function answer = cal(obj, targetVar)
            
            fn = fieldnames(obj);
            for ii = 1:length(fn)
                eval( sprintf('%s=obj.%s;', fn{ii}, fn{ii}) );
            end

            e = ['tan(angle ./ 2 .* pi./ 180) .* distance .* 2' ...
                 '.* sqrt(resolutionW.^2 + resolutionH.^2)/screenDiagonal' ...
                 '- stiPixel'];

            eval(sprintf('fun=@(%s)%s;', targetVar, e));
            options = optimset('Display','off');
            answer = fsolve(fun, 10, options) ;
        end
        
        
        
        
        
        function setParaGui(obj)
            fn = fieldnames(obj);            
            sInputDefAns = fn;
            
            for ii = 1:length(fn)
                sInputDefAns{ii} = num2str(obj.(fn{ii}));
            end
            sInputAnswer = inputdlg(fn, 'Set Parameter', 1, sInputDefAns);
            for ii = 1:length(fn)
                obj.(fn{ii}) = str2num(sInputAnswer{ii});
            end            
            disp(obj);
        end
        
        
        
        
        
        function getAnsPrompt(obj)
            fn = fieldnames(obj);
            disp('Choose the parameter you want to know:');
            for ii = 1:length(fn)                
                fprintf('%d)\t%s\n', ii, fn{ii});
            end
            iPara = input('');
            fprintf('%s: %.3f\n', fn{iPara}, obj.cal(fn{iPara}));
        end
        
        
        
        
        
        
    end
    
    
    
end