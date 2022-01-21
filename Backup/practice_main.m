function practice_main(paraFilename, taskAbbv, taskName)
%======================================================================%
% 1.0 - Acer 2013/02/10 08:58
%======================================================================%
%% Task GUI
% [selection, taskAbbv, taskIndex] = taskSelectionGUI();
% taskName = 'Motion Coherence Test';
% taskAbbv = 'colour';





%% Import 

% Library
% ---------------------------------------------------------------------- %
addpath( genpath('lib') );
disp('Lib imported');



% Parameters
% ---------------------------------------------------------------------- %
load(paraFilename);
% para = paraObj;







%% Initialize

% Psychtoolbox
%----------------------------------------------------------------------%
commandwindow();
PsyInitialize();
% Screen('Preference', 'SkipSyncTests', 1)
w = PsyScreen();

if strcmp(taskAbbv, 'shape')
    w.backgroundColor = [255 255 255]./2;
end

% w.openTest([100 100 700 700]);
w.open();



% Objects
%----------------------------------------------------------------------%
aObj = adaptObj();
switch taskAbbv
    
    
    case 'motion'
        rdm = PsyRdmObj(w, para.rdm);
        aObj.setPara(para.rdm.adapt); 
       
       
    case 'luminance'
        lum = PsyOval(w);
        lum.ObjSize = [para.lum.size para.lum.size];
        aObj.setPara(para.lum.adapt); 
       
       
    case 'shape'
        rf = rfObj;
        rf.setPsyPic(w);
        rf.setPara(para.shape);
        rf.createStandPic();
        aObj.setPara(para.shape.adapt); 
        
        
    case 'colour'
        cObj = PsyOval(w);
        cObj.ObjSize = [para.colour.size para.colour.size];
        aObj.setPara(para.colour.adapt);
        standColor = para.colour.adapt.maxIntensity;
        
        if isempty(para.colourLum.result)
            error('No data from Colour Luminance adjecting task.');
        end
       
       
end



fixation = PsyCross(w);


r = respObj(w, para.resp);


dObj = dataObj(para, taskAbbv);


% Feedback
feedbackObj = PsyText(w);
feedbackObj.color = [200 200 200];




%% Experiment Start
    for iTrail = 1:10
        %----------------------------------------------------------------------%
        % Adaptation procedure calculator
        %----------------------------------------------------------------------%
        dataTrial.intensity = aObj.newIntensity();
        dataTrial.intensity
        if ischar( dataTrial.intensity ), break, end
        
        

        %----------------------------------------------------------------------%
        % Fixation 
        %----------------------------------------------------------------------%
        fixationTime = fixation.play();
        
        while GetSecs - fixationTime < 1
        end
        
        flipTime = w.flip();
        
        while GetSecs - flipTime < 0.5
        end        
        
        
        
        
        %----------------------------------------------------------------------%
        % Task Presentation
        %----------------------------------------------------------------------%
        dataTrial.isSigFirst = rand() > 0.5;        
        
        switch taskAbbv
            
            
            case 'motion'
                if dataTrial.isSigFirst
                    rdm.newDots( dataTrial.intensity );
                    rdm.play();
                    
                    WaitSecs( para.g.isi );
                    
                    rdm.newDots( 0 );
                    rdm.play();
                else
                    rdm.newDots( 0 );
                    rdm.play();
                    
                    WaitSecs( para.g.isi );
                    
                    rdm.newDots( dataTrial.intensity );
                    rdm.play();                    
                end
                
                
                
            case 'luminance'
                if dataTrial.isSigFirst
                    
                    lum.color = [dataTrial.intensity,...
                                 dataTrial.intensity,...
                                 dataTrial.intensity];
                    lum.play();
                    WaitSecs(para.lum.duration);
                    w.flip();                             

                    WaitSecs( para.g.isi );

                    lum.color = [para.lum.standard,...
                                 para.lum.standard,...
                                 para.lum.standard];
                    lum.play();
                    WaitSecs(para.lum.duration);
                    w.flip();
                    
                else
                    
                    lum.color = [para.lum.standard,...
                                para.lum.standard,...
                                para.lum.standard];                    
                    lum.play();
                    WaitSecs(para.lum.duration);
                    w.flip();

                    WaitSecs( para.g.isi );

                    lum.color = [dataTrial.intensity,...
                                dataTrial.intensity,...
                                dataTrial.intensity];
                    lum.play();
                    WaitSecs(para.lum.duration);
                    w.flip(); 
                    
                end
                
                
                
            case 'shape'
                rf.createTestPic(dataTrial.intensity)
                if dataTrial.isSigFirst
                    rf.draw(0);
                    rf.flip();                          % Present
                    WaitSecs(para.shape.duration);        % 
                    t0 = w.flip();                      % Blank
                    rf.draw(1);
                    while GetSecs - t0 < para.g.isi - 0.005
                    end
                    rf.flip();
                    WaitSecs(para.shape.duration);
                    w.flip();
                else
                    rf.draw(1);
                    rf.flip();                          % Present
                    WaitSecs(para.shape.duration);        % 
                    t0 = w.flip();                      % Blank
                    rf.draw(0);
                    while GetSecs - t0 < para.g.isi - 0.005
                    end
                    rf.flip();
                    WaitSecs(para.shape.duration);
                    w.flip();
                end                
                
                
                
            case 'colour'
                
                if dataTrial.isSigFirst
                    cObj.color = i2c(dataTrial.intensity,...
                                        standColor,...
                                        para.colourLum.result(2));

                    cObj.play();
                    WaitSecs(para.colour.duration);
                    w.flip();                             

                    WaitSecs( para.g.isi );

                    cObj.color = [standColor,...
                                 0,...
                                 0];
                    cObj.play();
                    WaitSecs(para.colour.duration);
                    w.flip();
                    
                else                    

                    cObj.color = [standColor,...
                                 0,...
                                 0];
                             
                    cObj.play();
                    WaitSecs(para.colour.duration);
                    w.flip();                             

                    WaitSecs( para.g.isi );
                    
                    cObj.color = i2c(dataTrial.intensity,...
                                        standColor,...
                                        para.colourLum.result(2));

                    cObj.play();
                    WaitSecs(para.colour.duration);
                    w.flip();
                    
                end                
                
                
        end     %-----------------------------------end of task switch

        
        
        WaitSecs(0.3);
        

        %----------------------------------------------------------------------%
        % Response Stage
        %----------------------------------------------------------------------%
        dataTrial.resp = r.procedure();
        dataTrial.acc = resp2acc(para.resp.order,...
                            para.resp.key,...
                            {dataTrial.resp.keyName},...
                            dataTrial.isSigFirst);
        aObj.dataIn(dataTrial.acc);



        
        %----------------------------------------------------------------------%
        % Feedback Screen
        %----------------------------------------------------------------------%
        if dataTrial.acc
            feedbackObj.Text = 'Correct';
        else
            feedbackObj.Text = 'Incorrect';
        end
        feedbackObj.playCenter();        
        
        
        
        %----------------------------------------------------------------------%
        % Data login
        %----------------------------------------------------------------------%        
        
        
        % Subject Information
        %--------------------------------------------------------------
        data(iTrail).ID = para.subjInfo.ID;
        data(iTrail).gender = para.subjInfo.gender;
        data(iTrail).age = para.subjInfo.age;
        data(iTrail).handedness = para.subjInfo.handedness;

                
        % Task
        %--------------------------------------------------------------
        data(iTrail).task = taskName;
        data(iTrail).intensity = dataTrial.intensity;

        
        % Response
        %--------------------------------------------------------------
        data(iTrail).respkey = dataTrial.resp.keyName;
        data(iTrail).acc = dataTrial.acc;
        
        % save data
        %------------------------------------------------------------------
        % dObj.saveToTempFile(data);
        
        
        
        %----------------------------------------------------------------------%
        % End of the trial
        %----------------------------------------------------------------------%
        WaitSecs(0.5);
        
        
        
    end     % ========================================= end of trial loop
    
    
    
%----------------------------------------------------------------------
% Final Data login
%----------------------------------------------------------------------
% dObj.saveToFile();
% save(sprintf('data_%s_%s_all.mat', taskAbbv, obj.para.subjInfo.ID));
    
    
    
    
end