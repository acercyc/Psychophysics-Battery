function [vOut, idx] = realNumFilter(vIn)
%======================================================================%
% 1.0 - Acer 2013/10/06 13:58
%======================================================================%
idx = find(real(vIn) == vIn);
vOut = vIn(idx);
