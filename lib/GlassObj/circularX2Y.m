function y = circularX2Y(x, xRef, yRef)
%======================================================================%
% 1.0 - Acer 2013/10/06 13:35
%======================================================================%
kSquare = xRef^2 + yRef^2;
y = sqrt(kSquare - x.^2) .* ((yRef >= 0).*2 - 1);
