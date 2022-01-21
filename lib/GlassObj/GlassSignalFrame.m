function xy = GlassSignalFrame(nPairs, percentage, d, canvasRange)
%======================================================================%
% 1.0 - Acer 2013/10/07 00:46
%======================================================================%
signalDots = GlassSignalGen( round(nPairs * percentage), d, canvasRange);
noiseDots = randDots(round(nPairs * (1-percentage)), canvasRange);
xy = [signalDots;noiseDots];

xy = centerTo(xy, canvasRange./2);





