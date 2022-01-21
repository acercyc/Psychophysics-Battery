function p = findPointByDist(xRef, yRef, d, fun)
%======================================================================%
% 1.0 - Acer 2013/10/06 13:48
%======================================================================%
% Find x,y within range "d"
xVec = (xRef - d) : (xRef + d);
yVec = fun(xVec, xRef, yRef);

% Filter out complex number
[yVec, rIdx]= realNumFilter(yVec);
xVec = xVec(rIdx);

% Find the closest point
p = findClosestDistPoint(xVec, yVec, xRef, yRef, d);