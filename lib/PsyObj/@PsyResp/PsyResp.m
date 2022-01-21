classdef PsyResp < handle
% 1.0 - Acer 2011/06/08_11:06
% 1.1 - Acer 2012/11/22 08:45
%       Modify waitPress()
% 1.0.1 - Acer 2013/11/14 17:17
    properties
        % setting
        startTime;
        waitTime = 2;
        allowKey; % please refer to KeyDetector.m for detail
        allowKey_mouse;
        leaveAfterPress = 1;;
        
        % response
        keyIsDown;
        RT = NaN;
        respMoment;
        releaseMoment;  
        pressDuration;
        pressKey;        
        
        % state 
        pressFlag;
        pressTime;
        pressKeyArray;            
    end
    
%% Press methods    
    methods % for Keyboard
%======================================================================%
% Press
%======================================================================%
        function waitPress(obj, waitTime)               
            obj.initialPressResp;            
            if nargin == 2
                obj.waitTime = waitTime;
            elseif nargin == 1  % 2012/11/22 08:45
                obj.waitTime = inf;
            end
            KbReleaseWait;
            
            % waiting key loop
            obj.keyIsDown = [];
            while (GetSecs - obj.startTime) < obj.waitTime
                if obj.keyIsDown    % have pressed
                    if obj.leaveAfterPress; break; end  % leave loop if press        
                else                % haven't pressed
                    [obj.keyIsDown obj.respMoment obj.pressKey] = obj.KeyDetector(obj.allowKey);
                end
                pause(0.001);
            end
            
            % Data log in after press
            if obj.keyIsDown
                obj.RT = obj.respMoment - obj.startTime;
                obj.releaseMoment = [];
                obj.pressDuration = [];
            else
                obj.respDataClear;
            end
        end
        
%======================================================================%
% Long Press
%======================================================================%
        function waitLongPress(obj, waitTime)
            obj.initialPressResp;

            if nargin == 2
                obj.waitTime = waitTime;
            end
            KbReleaseWait;
            
            % waiting key loop
            obj.keyIsDown = 0;
%             if ~obj.timerObj_G.preRespCheck
            while (GetSecs - obj.startTime) < obj.waitTime
                if obj.keyIsDown    % have pressed
                    if obj.leaveAfterPress; break; end  % leave loop if press        
                else                % haven't pressed
                    [obj.keyIsDown obj.respMoment obj.pressKey] = obj.KeyDetector(obj.allowKey);
                end
            end
            
            if obj.keyIsDown
                obj.releaseMoment = KbReleaseWait;
                obj.RT = obj.respMoment - obj.startTime; 
                obj.pressDuration = obj.releaseMoment - obj.respMoment;
            else
                obj.respDataClear;
            end
        end
    end
    
    methods % for mouse
        function waitPress_mouse(obj, waitTime)               
            obj.initialPressResp;            
            if nargin == 2
                obj.waitTime = waitTime;
            end
            
            % waiting key loop
            obj.keyIsDown = [];
            while (GetSecs - obj.startTime) < obj.waitTime
                if obj.keyIsDown    % have pressed
                    if obj.leaveAfterPress; break; end  % leave loop if press        
                else                % haven't pressed
                    [obj.keyIsDown obj.respMoment obj.pressKey] = obj.MouseDetector(obj.allowKey_mouse);
                end
            end
            
            % Data log in after press
            if obj.keyIsDown
                obj.RT = obj.respMoment - obj.startTime;
                obj.releaseMoment = [];
                obj.pressDuration = [];
            else
                obj.respDataClear;
            end
        end
    
        function waitLongPress_mouse(obj, waitTime)
            obj.initialPressResp;

            if nargin == 2
                obj.waitTime = waitTime;
            end
            KbReleaseWait;
            
            % waiting key press loop
            obj.keyIsDown = 0;
            while (GetSecs - obj.startTime) < obj.waitTime
                if obj.keyIsDown    % have pressed
                    if obj.leaveAfterPress; break; end  % leave loop if press        
                else                % haven't pressed
                    [obj.keyIsDown obj.respMoment obj.pressKey] = obj.MouseDetector(obj.allowKey_mouse);
                end
            end
            
            % waiting key release loop
            while 1
                [keyDown obj.releaseMoment] = obj.MouseDetector(obj.allowKey);
                if ~keyDown
                    break;
                end
            end
            
            if obj.keyIsDown
                obj.RT = obj.respMoment - obj.startTime; 
                obj.pressDuration = obj.releaseMoment - obj.respMoment;
            else
                obj.respDataClear;
            end
        end
    end
    
    
%% Static function    
    methods (Static = true)
        [keyIsDown secs keyName keyCode] = KeyDetector(key);
        [keyIsDown secs buttonNum mousePosition] = MouseDetector(button);
        kbNameResult = KbName_acer(arg)
    end
    
    methods
        function set.waitTime(obj, value)
            if isempty(value)
                obj.waitTime = inf;
            else
                obj.waitTime = value;
            end
        end
    end

%% priviate tools    
    methods (Access = protected, Hidden = true)
        function initialPressResp(obj)
            obj.startTime = GetSecs;
        end
        
        function respDataClear(obj)
            obj.RT = [];
            obj.pressKey = [];
            obj.respMoment = [];
            obj.releaseMoment = [];
            obj.pressDuration = [];            
        end
        
    end
end