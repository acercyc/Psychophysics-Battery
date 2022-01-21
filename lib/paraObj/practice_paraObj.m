classdef practice_paraObj
%======================================================================%
% 10. - Acer 2013/02/10 09:06
%======================================================================%

    properties
        subjInfo = [];  % Subject information
        g = [];         % general
        
        
        % --- task ---
        rdm = [];
        lum = [];
        shape = [];
        colourLum = [];
        colour = [];
        
        
        resp = [];      % Response
    end
    
    
    
    
    
    methods
        
        
        
        function obj = practice_paraObj(subjInfo)
            
            %--------------------------------------------------------------
            % Subject information
            %--------------------------------------------------------------
            obj.subjInfo = subjInfo;
            
                % ---- modify by Acer - 2013/03/11 19:26 -------
                % obj.subjInfo.ID = 'test';
                % obj.subjInfo.gender = 'm';
                % obj.subjInfo.age = '28';
                % obj.subjInfo.handedness = 'r';
                % -----------------------------------------------                
            
            
            
            %--------------------------------------------------------------
            % General Experimental Parameters
            %--------------------------------------------------------------            
            obj.g.refreshRate = 85;
            obj.g.flipOffset = (1 / obj.g.refreshRate) / 2;
            obj.g.isi = 0.5 - obj.g.flipOffset;      % Inter-stimulus interval
                        
            
            
            
            %--------------------------------------------------------------
            % RDM test
            %--------------------------------------------------------------
            obj.rdm.n = 100;
            obj.rdm.dotSize = 10;       % 0~10
            obj.rdm.speed = 2;
            obj.rdm.color = [200, 200, 200];
            obj.rdm.pRange = [-200, -200, 200, 200];            
            obj.rdm.duration = 0.5;
            obj.rdm.adapt.initIntensity = 0.8;       % initial coherence
            obj.rdm.adapt.maxIntensity = 1;
            obj.rdm.adapt.minIntensity = 0;
            obj.rdm.adapt.intsChange = 0.02;
            obj.rdm.adapt.starecase = [3 1];
            obj.rdm.adapt.nStopAlt = 10;
            
            
            if obj.rdm.dotSize > 10
                error('Dot size should be within 10');
            end
            
            
            
            
            %--------------------------------------------------------------
            % GlassTest 
            %--------------------------------------------------------------
            obj.Glass.n = 200;
            obj.Glass.dist = 7;
            obj.Glass.dotSize = 3;       % 0~10
            obj.Glass.color = [200, 200, 200];
            obj.Glass.pRange = [500 500];            
            obj.Glass.duration = 0.145 - obj.g.flipOffset;
            obj.Glass.adapt.initIntensity = 0.4;  % initial coherence
            obj.Glass.adapt.maxIntensity = 1;
            obj.Glass.adapt.minIntensity = 0;
            obj.Glass.adapt.intsChange = 0.02;
            obj.Glass.adapt.starecase = [3 1];
            obj.Glass.adapt.nStopAlt = 10;
            
            
            if obj.Glass.dotSize > 10
                error('Dot size should be within 10');
            end
            
            
                        
            
            %--------------------------------------------------------------           
            % Luminance test
            %--------------------------------------------------------------
            obj.lum.size = 40;         
            obj.lum.duration = 0.5;
            obj.lum.standard = 125;
            obj.lum.adapt.initIntensity = 230;
            obj.lum.adapt.maxIntensity = 255;
            obj.lum.adapt.minIntensity = obj.lum.standard;
            obj.lum.adapt.intsChange = 3;
            obj.lum.adapt.starecase = [3 1];
            obj.lum.adapt.nStopAlt = 10;            
            
            
            
            %--------------------------------------------------------------            
            % Shape test
            %--------------------------------------------------------------
            obj.shape.rf.picResolution = 150;           % Resolution
            picSize = obj.shape.rf.picResolution ./ 2;       
            obj.shape.rf.Rm = picSize/2;                % the mean radius
            obj.shape.rf.Wp = 1/obj.shape.rf.Rm * 2;    % the width  of the line
            obj.shape.rf.C = 0.8;                       % contrast
            obj.shape.rf.Lm = 0.5;                      % the mean luminance
            obj.shape.rf.fr = 6;                        % Number of angle
            
            obj.shape.standard = 0;                % standard intensity
            obj.shape.duration = 0.5;
            
            obj.shape.adapt.initIntensity = 0.05;
            obj.shape.adapt.maxIntensity = 1;
            obj.shape.adapt.minIntensity = 0;
            obj.shape.adapt.intsChange = 0.0005;
            obj.shape.adapt.starecase = [3 1];
            obj.shape.adapt.nStopAlt = 10;            
            
            
            
            
            %--------------------------------------------------------------
            % Colour Luminance adjecting task
            %--------------------------------------------------------------
            obj.colourLum.size = 40;
            obj.colourLum.standard = [200 0 0];
            obj.colourLum.testInitial = [0 200 0];
            obj.colourLum.adjIntensity = [0 1 0];
            obj.colourLum.adjIntensity2 = [0 7 0];
            obj.colourLum.duration = 0.05;
            obj.colourLum.respKey = {{'z'}, {'/?'}, {'x'}, {'.>'}, {'ESCAPE'}};
            obj.colourLum.result = [0 130 0]; % Acer - 2013/03/18 01:23
            
            
            %--------------------------------------------------------------
            % Colour test
            %--------------------------------------------------------------
            obj.colour.size = 40;         
            obj.colour.duration = 0.5;
            obj.colour.standard = 0;
            
            obj.colour.adapt.initIntensity = 100;
            obj.colour.adapt.maxIntensity = obj.colourLum.standard(1);
            obj.colour.adapt.minIntensity = 0;
            obj.colour.adapt.intsChange = 5;
            obj.colour.adapt.starecase = [3 1];
            obj.colour.adapt.nStopAlt = 10;               
            
            
            %--------------------------------------------------------------
            % Response Obj
            %--------------------------------------------------------------
            obj.resp.handOrder = 1;
            obj.resp.key = {{'z'} {'/?'}};
            obj.resp.timeLimit = 2;
            
                % textObj
                obj.resp.textObj.color = [255 255 255];
                obj.resp.textObj.Text = 'Response';
            
            obj.resp.order = str2num(obj.subjInfo.respOrder);
                % response  order:
                % 1: obj.resp.key{1} then obj.resp.key{2}
                % 0: obj.resp.key{2} then obj.resp.key{1}
                
            
                
            
            %--------------------------------------------------------------
            % Save This object
            %--------------------------------------------------------------
            obj.saveToFile();
            
            
        end
        
        
        
        
        function saveToFile(obj)
            para = obj; %#ok<NASGU>
            save(sprintf('para_%s', obj.subjInfo.ID), 'para');
            disp('para file created');
        end
        
    end
end