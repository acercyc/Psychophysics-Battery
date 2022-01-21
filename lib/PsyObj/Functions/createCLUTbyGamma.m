function [v255, v01] = createCLUTbyGamma(gamma, inverse, level)
% [v255, v01] = createCLUTbyGamma(gamma)
%
%======================================================================
% 1.0 - Acer 2013/11/06 18:54
%=====================================================================

if ~exist('inverse', 'var'); inverse = 0; end
if ~exist('level', 'var'); level = 256; end

if numel(gamma) == 1
    gamma = repmat(gamma, 1, 3);
end

vIn = repmat(linspace(0, 1, level)', 1, 3);
if inverse; gamma = 1./gamma; end

v01 = bsxfun(@power, vIn, gamma);
v255 = v01 .* 255;


