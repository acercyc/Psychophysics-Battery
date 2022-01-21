function  [dotsAll, dots1, dots2] = randDipoles(nPairs, d, canvasRange)
%======================================================================%
% 1.0 - Acer 2013/10/07 00:13
%======================================================================%

% Generate random angles
angle = rand(nPairs, 1) .* 2 .* pi;

% Generate random Shift
shift = rand(nPairs, 2);
shift = bsxfun(@times, shift, canvasRange - 2*d);
shift = shift + d;

% Generate Random Dipoles
dots1 = zeros(nPairs, 2) +shift;
dots2 = round(rotateAndShift(angle, shift, d));

dotsAll = [dots1; dots2];
 