classdef PsyScreen < handle
% 1.0 - Acer 2011/05/27_23:32
% 1.1 - Acer 2011/07/22_14:13
%       Add openOffScreenWindow function
% 1.2 - Acer 2012/10/25 15:15
%       Delete timing function 
% n.n - Acer 2013/11/06 20:25
    properties
        % window property after open a window
        windowPtr;
        windowNum;      
        windowSize;
        windowRect;
        windowInfo;
        
        resolustion_experiment = struct('width', 1024, 'height', 768, 'pixelSize', 32, 'hz', 60);
        resolustion_original;
        resolustion_old;
        resolustion_available;
        
        xcenter;
        ycenter;
        backgroundColor = [0 0 0];
        
        ctrl_hideCursor = true;
        ctrl_hideCharInCommWin = false;
        ctrl_setResolution = false;
        
        winOpenTime;
        winCloseTime;
    end
    
    %% Methods for open and close
    methods
        function obj = PsyScreen(windowNum)
        % Constructor: creat a screen OBJ
        % Default screen is 0;
            % set defult
            if nargin < 1; windowNum = 0; end 
            obj.windowInfo = Screen('Resolution', windowNum);
            obj.resolustion_original = obj.windowInfo;
            obj.windowNum = windowNum;
            obj.resolustion_available= Screen('Resolutions', obj.windowNum);
        end
        
        function open(obj)            
            if obj.ctrl_setResolution % set resolution
                resolutionSet(obj);
            end
            % open
            [obj.windowPtr, obj.windowRect] = Screen('openwindow',obj.windowNum, obj.backgroundColor, obj.windowSize);
            obj.winOpenTime = GetSecs;
            obj.xcenter = obj.windowRect(3)/2;
            obj.ycenter = obj.windowRect(4)/2;
            if obj.ctrl_hideCursor; HideCursor;end
            if obj.ctrl_hideCharInCommWin;  ListenChar(2); end
            
            % Acer - 2013/11/06 20:25
            [~, v01] = createCLUTbyGamma(2.468, 1);
            Screen('LoadNormalizedGammaTable', obj.windowNum, v01);
        end

        function openOffscreen(obj, winNum)      
            if obj.ctrl_setResolution % set resolution
                resolutionSet(obj);
            end
            obj.windowNum = winNum;
            [obj.windowPtr, obj.windowRect] = Screen('OpenOffscreenWindow',obj.windowNum, obj.backgroundColor, obj.windowSize);
            obj.winOpenTime = GetSecs;
            obj.xcenter = obj.windowRect(3)/2;
            obj.ycenter = obj.windowRect(4)/2;
        end
        
        function openTest(obj, testSize)
            % open for experimental test >> just show in a small window
            if ~exist('testSize', 'var'); testSize = [100 100 1000 600]; end
            obj.windowSize = testSize;
            obj.ctrl_hideCursor = false;
            obj.open;
        end
        
        function close(obj)
            obj.winCloseTime = GetSecs;
            
            % Acer - 2013/11/06 20:26
            [~, v01] = createCLUTbyGamma(1, 1);
            Screen('LoadNormalizedGammaTable', obj.windowNum, v01);
            obj.flip();
            Screen('Close', obj.windowPtr);
            ShowCursor;
            if obj.ctrl_hideCharInCommWin
                ListenChar(1);
            end
             
            if obj.ctrl_setResolution
                obj.resolustion_old = SetResolution(obj.windowNum, obj.resolustion_original);
            end
        end
        
        function delete(obj)
            obj.close;
        end
        
        function flipTime = flip(obj)
            flipTime = Screen(obj.windowPtr,'Flip');
        end
    end
    
    %% Methods for screen resolution
    methods
        function resolutionDisp(obj) %#ok<MANU>
        % Display current resolution and avaliable resolution
            ResolutionTest;
        end
        
        function resolutionSet(obj, varargin)
        % set resolution by two ways
        % 1st >> resolutionSet(width, height, hz, pixelSize)
        % 2nd >> resolutionSet >> set by build-in property: resolustion_experiment
        % 1.0 - Acer 2011/05/28_17:24
            obj.resolustion_old = obj.windowInfo;
            try
                if numel(varargin) > 0
                    obj.resolustion_old = SetResolution(obj.windowNum, varargin{1}, varargin{2}, varargin{3}, varargin{4});
                elseif  numel(varargin) == 0
                    obj.resolustion_old = SetResolution(obj.windowNum, obj.resolustion_experiment);
                end
            catch err
                resol_t = nearestResolution(obj.windowNum, obj.resolustion_experiment);
                war_t = sprintf('Resolution is not exist. Set as nearest resolution.\nwidth = %d\nhight = %d\npixelSize = %d\nhz = %d\n', resol_t.width, resol_t.height, resol_t.pixelSize, resol_t.hz);
                h = warndlg(war_t);
                uiwait(h);
                obj.resolustion_old = SetResolution(obj.windowNum, resol_t);
                rethrow(err);
            end   
        end   
    end
end