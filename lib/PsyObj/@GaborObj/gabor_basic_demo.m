% Acer 2013/10/10 16:23
clc;
clear all;

s = 1;
resolution = 500;
f = 4;
theta = 0;
sigma = s / norminv(.999, 0, 1) / 2;
phase = 0;
L0 = 0.5;
c = 1;
xGamma = 1;
yGamma = 1;
%%
figure();
v = gabor_basic(s, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma);
gshow(v);

