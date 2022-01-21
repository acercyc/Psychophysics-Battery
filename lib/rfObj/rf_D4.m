function  value = rf_D4(r, C, Lm)
%======================================================================%
% C : pattern contrast
% r0: the mean radius
% sigma: determines  the  peak  spatial  frequency
% 1.0 - Acer 2013/03/07 15:24
%======================================================================%
    if Lm > 1 || Lm < 0
        error('Wp is not within 0~1 range');
    end
    value = Lm .* ( 1 + C.*(1-4.*r.^2 + 4./3.*r.^4) .* exp(-r.^2) );


end