function colourLumAdjTask(paraFilename)
%======================================================================%
% 1.0 - Acer 2013/03/05 13:52
%======================================================================%


%% Import 

% Library
% ---------------------------------------------------------------------- %
addpath( genpath('lib') );
disp('Lib imported');



% Parameters
% ---------------------------------------------------------------------- %
para = [];
load(paraFilename);





%% Initialize

% Psychtoolbox
%----------------------------------------------------------------------%
% commandwindow();
PsyInitialize();
% Screen('Preference', 'SkipSyncTests', 1)
w = PsyScreen();
% w.openTest([100 100 700 700]);
w.open();



% Objects
%----------------------------------------------------------------------%
c = PsyOval(w);
c.ObjSize = [para.colourLum.size para.colourLum.size];
testColor = para.colourLum.testInitial;

% txt = PsyText(w);
% txt.textSize = 20;
% txt.color = [100 100 100];
% txt.xy = []

%% Experiment Start
while 1
    
    %---------------------------------------------------------------------
    % Present standard
    %---------------------------------------------------------------------
    c.color = para.colourLum.standard;
    t0 = c.play(); 
    
    while GetSecs - t0 < para.colourLum.duration - 0.005
    end
    
    
    
    %---------------------------------------------------------------------
    % Present Test
    %---------------------------------------------------------------------
    c.color = testColor;
    t0 = c.play();

    
    
    % keyDown check
    %----------------------------------------------------------------------
    [isKeyDown, ~, keyName] = ...
        KeyDetector( para.colourLum.respKey );
    if isKeyDown
        
        if strcmp(keyName, para.colourLum.respKey{1})            
            testColor = testColor + para.colourLum.adjIntensity;
            
        elseif strcmp(keyName, para.colourLum.respKey{2})            
            testColor = testColor - para.colourLum.adjIntensity;       
            
        elseif strcmp(keyName, para.colourLum.respKey{3})
            testColor = testColor + para.colourLum.adjIntensity2;    
            
        elseif strcmp(keyName, para.colourLum.respKey{4})
            testColor = testColor - para.colourLum.adjIntensity2;    
            
        elseif strcmp(keyName, para.colourLum.respKey{5})            
            break;
            
        end   
        
        % check if color value exceeds 0~255
        if any(testColor > 255)
            testColor( testColor > 255 ) = 255;
        elseif any(testColor < 0)
            testColor( testColor < 0 ) = 0;
        end        
        
    end     %-------------------------------------end of keyDown check
    
    
    fprintf('color = [%d\t%d\t%d]\n', testColor);
    while GetSecs - t0 < para.colourLum.duration - 0.005
    end

end
    


%======================================================================%
% Save Data
%======================================================================%
para.colourLum.result = testColor;
save(sprintf('para_%s', para.subjInfo.ID), 'para');
end