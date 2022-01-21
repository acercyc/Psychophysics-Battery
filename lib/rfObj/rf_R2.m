function value = rf_R2(x, y, fr, theta, Rm, A)
%======================================================================%
% 1.0 - Acer 2013/03/07 15:50
%======================================================================%
    if mod(fr, 1) ~= 0
        error('radial frequency (fr) need to be integer.');
    end
    value = Rm.* (  1 + A .* sin( fr.*atan2(y,x) + theta )  );

end