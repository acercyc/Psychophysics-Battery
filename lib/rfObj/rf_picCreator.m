function rf = rf_picCreator(picResolution, fr, theta, C, Lm, Rm, A, Wp)
%======================================================================%
% 1.0 - Acer 2013/013/11 06:26
%======================================================================%
    ps = picResolution ./ 2;
    x = -ps:ps;
    y = -ps:ps;
    rf = NaN(length(x), length(y));
    for iy = 1:length(y)
        rf(:, iy) = rf_D4creator(x, y(iy), fr, theta, C, Lm, Rm, A, Wp);
    end
end