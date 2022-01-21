function v = o2r(g)
%======================================================================%
% Origial Colour to corrected colour
% 1.0 - Acer 2013/03/11 17:00
%======================================================================%

% [gammatable, dacbits, reallutsize]  = Screen('ReadNormalizedGammaTable', 0);
% [fit_out,x,fitComment] = FitGamma( (1:256)'./ 256, gammatable(:, 1), (1:10)',1)

v = ( (g ./ colourMax) .^ (gammaPower) ) .* colourMax;