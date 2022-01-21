clc;
clear all;
clear classes;

addpath(genpath('lib'));

%%
PsyInitialize;
w = PsyScreen(1);
w.openTest([50 50 400 400]);

%%
para.colour = [255 255 255];
para.size = 30;
para.ecentDist = 200;
para.totalDuration = 1;



%%
TOJ = tojObj(w, para);

%%
TOJ.targetObj.color = [100 100 100];
for ii = 1:10
    s = rand() > 0.5;
    TOJ.play(s, 0.004);
end
