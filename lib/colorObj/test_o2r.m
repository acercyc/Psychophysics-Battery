clc;
clear all;

g = 0:255;
v = o2r(g);
plot(g, v);
hold on 
g2 = r2o(v);
plot(v, g2, 'r');