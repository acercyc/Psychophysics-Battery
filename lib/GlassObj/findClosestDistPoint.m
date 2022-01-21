function p = findClosestDistPoint(x, y, xRef, yRef, d)
%======================================================================%
% 1.0 - Acer 2013/10/06 14:08
%======================================================================%
d2 = eulaDist(x, y, xRef, yRef) - d;
[~, idx] = min(abs(d2));
p = round([x(idx), y(idx)]);

