clc;
clear all;

angle = 1;
resolution = 500;
f = 4;
sigma = 0.25;
theta = 0;
phase = 0;
L0 = 0.5;
c = 1;
xGamma = 1;
yGamma = 1;

figure();
v = gabor_by_VisualAngle(angle, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma);
gshow(v);