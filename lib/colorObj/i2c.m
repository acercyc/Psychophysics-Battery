function c = i2c(intensity, intensity0, gMax)
%======================================================================%
% intensity to colour
% 1.0 - Acer 2013/03/11 17:48
%======================================================================%
c(1) = intensity0 - intensity;                  % R
c(2) = red2green(intensity0, c(1), 0, gMax);    % G
c(3) = 0;                                       % B