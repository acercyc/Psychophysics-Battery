function main(paraFilename, taskAbbv, taskName)
%======================================================================%
% 1.0 - Acer 2013/02/10 08:58
% 1.0.1 - Acer 2013/11/14 17:15
%         Add instruction screen
% 1.0.2 - Acer 2013/11/15 19:43
%         Slightly change the data saving mechanism
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
% commandwindow();
PsyInitialize();
% Screen('Preference', 'SkipSyncTests', 1)
w = PsyScreen(0);
% w.ctrl_hideCharInCommWin = true;

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

    case 'GlassTest'
        GlassDots = PsyDots(w);
        GlassDots.dotSize = para.Glass.dotSize;
        aObj.setPara(para.Glass.adapt);         
       
    case 'TOJ'
        TOJ = tojObj(w, para.toj);
        aObj.setPara(para.toj.adapt);
        
       
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


% dObj = dataObj(para, taskAbbv);


prompt = PsyText_Prompt(w);






%% Experiment Start
prompt.color = [255 255 255];
prompt.playWelcome();

% Instruction
prompt.checkAndPlayInstruction_imgfile(taskAbbv);



for iTrial = 1:inf
    %----------------------------------------------------------------------%
    fprintf('\n\nTrial = %d\n----------------\n', iTrial);
    
    
    
    %----------------------------------------------------------------------%
    % Adaptation procedure calculator
    %----------------------------------------------------------------------%
    dataTrial.intensity = aObj.newIntensity();
    if ischar( dataTrial.intensity ), break, end



    %----------------------------------------------------------------------%
    % Fixation 
    %----------------------------------------------------------------------%
    fixationTime = fixation.play();

    while GetSecs - fixationTime < 1
    end

%     flipTime = w.flip();
% 
%     while GetSecs - flipTime < 0.5
%     end        




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


        case 'GlassTest'
            if dataTrial.isSigFirst
                GlassDots.xy = GlassSignalFrame(para.Glass.n,...
                    dataTrial.intensity, para.Glass.dist, para.Glass.pRange)';
                GlassDots.play();
                WaitSecs( para.Glass.duration);
                w.flip();

                WaitSecs( para.g.isi );

                GlassDots.xy = GlassNoiseFrame(para.Glass.n,...
                    dataTrial.intensity, para.Glass.dist, para.Glass.pRange)';
                GlassDots.play();
                WaitSecs( para.Glass.duration);
                w.flip();                    
            else
                GlassDots.xy = GlassNoiseFrame(para.Glass.n,...
                    dataTrial.intensity, para.Glass.dist, para.Glass.pRange)';
                GlassDots.play();
                WaitSecs( para.Glass.duration);
                w.flip();

                WaitSecs( para.g.isi );

                GlassDots.xy = GlassSignalFrame(para.Glass.n,...
                    dataTrial.intensity, para.Glass.dist, para.Glass.pRange)';
                GlassDots.play();
                WaitSecs( para.Glass.duration);
                w.flip();                    
            end
            
            
            
        case 'TOJ'
            TOJ.play(dataTrial.isSigFirst,...
                     dataTrial.intensity - para.g.flipOffset);




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
    
    switch taskAbbv    
        case 'TOJ'
        dataTrial.acc = resp2acc(1,...
                            para.resp.key,...
                            {dataTrial.resp.keyName},...
                            dataTrial.isSigFirst);  
                        
        otherwise
        dataTrial.acc = resp2acc(para.resp.order,...
                            para.resp.key,...
                            {dataTrial.resp.keyName},...
                            dataTrial.isSigFirst);            
    end
    aObj.dataIn(dataTrial.acc);
    
    
    % response display
    fprintf('Intensity:\t %f\n', dataTrial.intensity);
    fprintf('Response Key:\t %s\n', dataTrial.resp.keyName);
    fprintf('acc:\t %d\n', dataTrial.acc);
    




    %----------------------------------------------------------------------%
    % Data login
    %----------------------------------------------------------------------%        


    % Subject Information
    %--------------------------------------------------------------
    data(iTrial).ID = para.subjInfo.ID;
    data(iTrial).gender = para.subjInfo.gender;
    data(iTrial).age = para.subjInfo.age;
    data(iTrial).handedness = para.subjInfo.handedness;


    % Task
    %--------------------------------------------------------------
    data(iTrial).task = taskName;
    data(iTrial).intensity = dataTrial.intensity;


    % Response
    %--------------------------------------------------------------
    data(iTrial).respkey = dataTrial.resp.keyName;
    data(iTrial).acc = dataTrial.acc; %#ok<*AGROW>
    

    % save data
    %------------------------------------------------------------------
    % dObj.saveToTempFile(data);
    save(sprintf('data_%s_%s_temp.mat', taskAbbv, para.subjInfo.ID));



    %----------------------------------------------------------------------%
    % End of the trial
    %----------------------------------------------------------------------%
    WaitSecs(0.5);
     

end     % ========================================= end of trial loop
    
    
    
%----------------------------------------------------------------------
% Final Data login
%----------------------------------------------------------------------
% dObj.saveToFile(data);
save(sprintf('data_%s_%s.mat', taskAbbv, para.subjInfo.ID));
    
    
    
    
end