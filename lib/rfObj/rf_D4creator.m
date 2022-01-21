function value = rf_D4creator(x, y, fr, theta, C, Lm, Rm, A, Wp)
%======================================================================%
% x
% y
% fr : radial frequency (angle number, should be integer)
% theta : the phase of the modulation
% C : contrast (I think [1] is normal)
% Lm : the mean luminance of the pattern (0 ~ 1, 0.5 is gray)
% Rm : the mean radius
% A : the amplitude of modulation (angle strenth)
% Wp : D4 peak spatial frequency (the width  of the line)
%
% 1.0 - Acer 2013/03/07 16:15
%======================================================================%
    sigma = rf_sigma(Wp);
    R = rf_R2(x, y, fr, theta, Rm, A);
    r = rf_r(x, y, R, sigma);
    value = rf_D4(r, C, Lm);
end