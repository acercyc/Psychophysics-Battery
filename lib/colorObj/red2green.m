function g1 = red2green(r0, r1, g0, gMax)
%======================================================================%
% 1.0 - Acer 2013/03/11 14:36
%======================================================================%
r0 = cScl(r0);
r1 = cScl(r1);
g0 = cScl(g0);
gMax = cScl(gMax);

gammaDist = ( gammaF(r0) - gammaF(r1) ) ./ gammaF(r0);
g1 = gammaFinv( (gammaF(g0) ./ gMax + gammaDist ) .* gammaF(gMax) );

g1 = cSclInv(g1);
