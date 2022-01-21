%======================================================================%
% 1.0 - Acer 2013/11/08 16:46
%======================================================================%

clc;
clear all;
clear classes;

%% Set parameters
para.intsChange = 1;
para.initIntensity = 50;
para.starecase = [3 1];        % 3 down 1 up
para.nStopAlt = 7;             % reversal number
para.maxIntensity = 100;
para.minIntensity = 0;


%% Create and initialise adaptObj
a = adaptObj;
a.setPara(para); 

%% Simulate response
while 1
    
    % Request for new intensity
    intensity = a.newIntensity();
    
    % Check reversal number is reached
    if ischar( intensity ); break; end
    
    % add response to the obj
    resp = rand() > 1/sum(para.starecase);
    a.dataIn( resp );
    
    % display
    fprintf('Trial = %d\tintensity = %g\tresp = %d\n',...
        a.iTrial,...
        a.currIntensity,...
        resp);
    
end

%% Plot result
figure();

dInten = [a.data.intensity];
dCorrect = find( [a.data.acc] );
dIncorrect = find( ~[a.data.acc] );
dRev = find( diff([a.data.nAlt]) );

hold on
plot(dInten);
plot( dCorrect, dInten(dCorrect), 'or');
plot( dIncorrect, dInten(dIncorrect), 'og');
plot( dRev, dInten(dRev), 'ks', 'MarkerSize',15);
xlabel('Trial #');
ylabel('Intensity');


legHandle = legend({'intensity',...
                    'correct respones',...
                    'incorrect response',...
                    'reversal point'},...
                    'Location','NorthEastOutside');        

