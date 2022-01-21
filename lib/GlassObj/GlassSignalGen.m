function [dotsAll, dots1, dots2] = GlassSignalGen(pairNum, d, canvasRange)
%======================================================================%
% 1.0 - Acer 2013/10/06 18:41
%======================================================================%

% Generate 
dots1 = randDotGen(pairNum, canvasRange);

%%% This is just for Circular %%%
dots1 = checkRandDotForCircular(dots1, d, canvasRange);
%%% ------------------------- %%%

% Center to Center
dots1 = centerTo(dots1, canvasRange ./ 2);


% Find Dipoles
dots2 = NaN(size(dots1,1), size(dots1,2));
for ii = 1:size(dots2, 1)
    xRef = dots1(ii, 1);
    yRef = dots1(ii, 2);
    dots2(ii,:) = findPointByDist(xRef, yRef, d, @circularX2Y);
end

% combine
dotsAll = [dots1; dots2];
dotsAll = centerTo(dotsAll, -canvasRange ./ 2);