function main_qCSF(paraFilename)
%======================================================================%
% 1.0 - Acer 2013/10/22 08:45
% 1.1 - Acer 2013/11/06 10:39
% 2.0 - Acer 2013/11/06 11:22
%       For integrating to PB
% 2.0.1 - Acer 2013/11/14 17:15
%         Add instruction screen
% 2.0.2 - Acer 2013/11/15 19:38
%         Slightly change data save name
%======================================================================%

%% Parameters
% Parameters
% ---------------------------------------------------------------------- %
taskAbbv = 'qCSF';
 
% exp
if ~exist('paraFilename', 'var')
    para.gabor.angle = 3;
    para.gabor.resolution = 140;
    para.exp.nTrial = 100;
    para.exp.fix.dura = 0.25;
    para.exp.blank1.dura = 0.3;
    para.exp.gabor.dura = 0.12;
    para.exp.isi.dura = 0.5;
    para.resp.dura = 2;
    para.resp.key = {{'z'}, {'/?'}, {'ESCAPE'}};
    para.exp.iti.dura = 0.5;
    
    para.qCSF.initialGuess = [100 2 3 0.5];
    % [peak sensitivity, peak frequency, bandwidth, low-frequency truncati]
    
    
else
    para = [];
    load(paraFilename);
    para_All = para;
    para =  para.qCSF;    
end




%% Open Screen
PsyInitialize;
w = PsyScreen(0);
w.backgroundColor = floor([255 255 255]./2);
w.open();
% w.openTest([50 50 400 400]);

para.screen.offset = 1 / w.windowInfo.hz / 2;


    
    
%% Initialize objects
% Gabor
g = GaborObj;
g.s = para.gabor.angle;
g.resolution = para.gabor.resolution;


% qcsf object
qcsf = setupQCSF;
qcsf = setupPriors(qcsf, para.qCSF.initialGuess);

% welcome 
wel = PsyText_Prompt(w);

% fixation
fix = PsyCross(w);
fix.color = [255 255 255]/3*2;

% fixation 2
fixDot = PsyOval(w);
fixDot.ObjSize = [6 6];


% Gabor Picture Object
gp = PsyPic(w);


% Response word
% respWord = PsyText(w);
% respWord.Text = 'Response';






%% Exp start
wel.color = [0 0 0];
wel.playWelcome();

% Instruction
wel.checkAndPlayInstruction_imgfile(taskAbbv);


for iTrial = 1:para.exp.nTrial
    
    % ----------------------------------------------------------------------
    % trial initialize
    % ----------------------------------------------------------------------
    % qcsf
    qcsf.data.trial = iTrial; 
    [qcsf, nextFrequency, nextContrast]=runQCSF_BETA(qcsf,'pretrial');
    
    % Gabor
    g.f = nextFrequency;
    g.c = nextContrast;
    gp.imgArray = floor(g.makeGabor * 255);
    
    % Gabor order
    data(iTrial).order = rand() > 0.5;
    % ----------------------------------------------------------------------
    
    
    
 
    % Blank1
    fixDot.draw();
    data(iTrial).timing_blank1 = w.flip(); %#ok<*SAGROW>
    WaitSecs(para.exp.blank1.dura);   
    
    
    % fixation 
    data(iTrial).timing_fix = fix.play();
    WaitSecs(para.exp.fix.dura);    

    if data(iTrial).order 
        data(iTrial).interval1 = gp.play();
    else
        data(iTrial).interval1 = w.flip();
    end
    
    while (GetSecs - data(iTrial).interval1) < ...
          (para.exp.gabor.dura - para.screen.offset)
    end    
    
    
    % ISI 
    w.flip();
    WaitSecs(para.exp.isi.dura); 
    
    
    % fixation 
    data(iTrial).timing_fix = fix.play();
    WaitSecs(para.exp.fix.dura);      
    
    if data(iTrial).order 
        data(iTrial).interval2 = w.flip();
    else
        data(iTrial).interval2 = gp.play();
    end    
    
    while (GetSecs - data(iTrial).interval2) < ...
          (para.exp.gabor.dura - para.screen.offset)
    end        

    
    % Response 
    data(iTrial).timing_respStart = w.flip(); %#ok<*AGROW>
    keyIsDown = 0;
    while (GetSecs - data(iTrial).timing_respStart) < para.resp.dura
        [keyIsDown, data(iTrial).timing, keyName] = KeyDetector(para.resp.key);
        if keyIsDown; break; end
    end
    
    % Exit Expeirment
    if strcmp(keyName, 'ESCAPE'); break; end
    
    
    if keyIsDown
        response = resp2accQCSF(para_All.resp.order, ...
            para.resp.key(1:2), {keyName}, data(iTrial).order);
    else
        response = 0;
    end
    
    

    % response display
    fprintf('\n\nTrial = %d\n----------------\n', iTrial);
    fprintf('Gabor Position\t %d\n', data(iTrial).order);
    fprintf('Response Key:\t %s\n', keyName);
    fprintf('acc:\t %d\n', response);
    
    
    % Post trial blank
    w.flip();
    WaitSecs(para.exp.iti.dura);
    
    
    
    % Post trial qcsf update
    qcsf.data.history(iTrial,:) = [iTrial nextFrequency nextContrast response];
    qcsf=runQCSF_BETA(qcsf,'posttrial',response);
    
    
    % Save data
    save(sprintf('data_%s_%s_temp.mat', taskAbbv, para_All.subjInfo.ID));
    
end

%% End experiment
w.close();


% Save Data
save(sprintf('data_%s_%s.mat', taskAbbv, para_All.subjInfo.ID));

%% Post experiment plot
% qcsf=runQCSF_BETA(qcsf,'plot experiment');


