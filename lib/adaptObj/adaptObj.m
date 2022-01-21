classdef adaptObj < handle
%======================================================================%
% 1.0 - Acer 2013/02/15 20:51
%======================================================================%

    properties
        
        para
        intsChange
        starecase
        initIntensity
        maxIntensity
        minIntensity
        
        nStopAlt
        
        currIntensity = [];
        iTrial = 0;
        accBuff = [0 0];
        
        data = [];
        
    end
    
    
    
    
    
    
    
    properties (Dependent = true)
        
        nAlt
        
    end
    
    
    
    
    
    
    
    methods
        
        
        
        
        
        function obj = adaptObj()
        end
        
        
        
        
        
        function setPara(obj, para)
            obj.para = para;
            obj.intsChange = para.intsChange;
            obj.starecase = para.starecase;
            obj.nStopAlt = para.nStopAlt;
            obj.initIntensity = para.initIntensity; %#ok<*CPROP,*PROP>            
            obj.currIntensity = para.initIntensity;
            obj.maxIntensity = para.maxIntensity;
            obj.minIntensity = para.minIntensity;
            
        end
        
        
        
        
        
        function dataIn(obj, acc)
            
            obj.data( obj.iTrial ).acc = acc;
            
            if acc
                obj.accBuff(1) = obj.accBuff(1) + 1;
            else
                obj.accBuff(2) = obj.accBuff(2) + 1;
            end            
                        
        end
        
        
        
        
                
        function isDown = stareCal(obj)
            
            accCheck = obj.accBuff == obj.starecase;
            if any(accCheck)
                
                if find(accCheck) == 1
                    isDown = 1;
                else
                    isDown = 0;
                end
                
                obj.accBuff = [0, 0];
                
            else
                
                isDown = -1;    % stay on this level
                
            end
                        
        end
        
        
        
        
        
        function v = newIntensity(obj)            
            
            obj.iTrial = obj.iTrial + 1;
            isDown = obj.stareCal();
            
            obj.data( obj.iTrial ).isDown = isDown;
            obj.data( obj.iTrial ).nAlt = obj.nAlt;

            
            
            if obj.nAlt >= obj.nStopAlt
                v = 'Stop';
                return
            end
            
            
            
            if isDown == 1
                
                obj.currIntensity = obj.currIntensity - obj.intsChange;
                if obj.currIntensity < obj.minIntensity
                    obj.currIntensity = obj.minIntensity;
                end
                
            elseif isDown == 0
                
                obj.currIntensity = obj.currIntensity + obj.intsChange;                
                if obj.currIntensity > obj.maxIntensity
                    obj.currIntensity = obj.maxIntensity;
                end
                                
            end
            
            
            
            obj.data( obj.iTrial ).intensity = obj.currIntensity;
            v = obj.currIntensity;            
            
        end
        
        
        
        
        
    end
    
    
    
    
    
    
    %=====================================================================%
    % Dependent Properties
    %=====================================================================%
    methods
                                
        
        
        function v = get.nAlt(obj)
            isDown_vec = [obj.data.isDown];
            isDown_vec( isDown_vec==-1) = [];
            v = sum(  abs( diff(isDown_vec) )  );
        end
                
        
        
    end
    
    
    
    
    
    
    
end