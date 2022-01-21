function v = gabor_by_VisualAngle(angle, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma)
%======================================================================%
% angle: visual angle of the stimuli
% resolution: Gabor size in pixel
% theta: direction
% f: spatial frequency in cycle/degree
% c: maximum intensity of the 
% L0: background/base luminance 


% 1.0 - Acer 2013/10/11 10:02
%======================================================================%


% sigma = angle / 13 * 1.87;
% v = gabor_basic(angle, resolution, theta, f, tau, c, L0);
v = gabor_basic(angle, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma); 