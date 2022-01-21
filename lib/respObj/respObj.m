classdef respObj < handle
%======================================================================%
% 1.0 - Acer 2013/02/10 09:46
% 1.1 - Acer 2013/03/20
%       Add esc as the abort key
% 1.0.1 - Acer 2013/11/14 17:19
%======================================================================%
    
    properties
        w
        para
        
        iTrial = 0;
        
        data
        textObj
    end
    
    
    
    
    
    
    
    methods 
        function obj = respObj(w, para)            
            
            % initialize
            % -------------------------------------------------------------
            obj.w = w;
            obj.para = para;
            
            
            
            % stimuli initialize
            % -------------------------------------------------------------
            obj.textObj = PsyText(w);
            obj.textObj.color = [255 255 255];
            obj.textObj.Text = 'Response';            
            
        end
        
        
        
        
        
        function dataTrial = procedure(obj)            
            obj.iTrial = obj.iTrial + 1;
            ii = obj.iTrial;
            
            
            
            obj.textObj.drawCenter();
            obj.data(ii).respScreenTime = obj.textObj.flip();
            
            
            
            isKeyDown = false;
            while ~isKeyDown
                [isKeyDown, obj.data(ii).keyTime, obj.data(ii).keyName] = ...
                    KeyDetector( obj.para.key );
                if KeyDetector( {'ESCAPE'} )
                    error('program abort');
                end
                pause(0.001);
            end            
            
            dataTrial = obj.data(ii);
            
        end
        
        
        
        
        
    end
  
end