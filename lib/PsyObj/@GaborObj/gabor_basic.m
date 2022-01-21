function v = gabor_basic(s, resolution, f, theta, sigma, phase, L0, c, xGamma, yGamma) 
%======================================================================%
% Create Gabor Patch
%
% !!! All unit are in the standard space !!!
%
% s: size of the canvas
% resolution: fineness of the Gabor
% f: spatial frequency
% theta: angle of tthe grating 
% sigma: standard deviation of the mask sin function 
%      which constrains the size of the gabor. Default = 2
% phase: The phase of the grating
% c: contrast/range; Default = 1
% L0: background/base luminance; Defaault = 0.5
% xGamma, yGamma: Scaling multiplier of x and y direction of the mask
%
% 1.0 - Acer 2013/10/19 07:45
%======================================================================%
if ~exist('s', 'var'); s = 7; end
if ~exist('resolution', 'var'); resolution = 400; end
if ~exist('f', 'var'); f = 1; end
if ~exist('theta', 'var'); theta = 0; end
if ~exist('sigma', 'var'); sigma = 1; end
if ~exist('phase', 'var'); phase = 0; end
if ~exist('L0', 'var'); L0 = 0.5; end
if ~exist('c', 'var'); c = 1; end
if ~exist('xGamma', 'var'); xGamma = 1; end; 
if ~exist('yGamma', 'var'); yGamma = 1; end;

if isempty(s); s = 7; end
if isempty(resolution); resolution = 400; end
if isempty(f); f = 1; end
if isempty(theta); theta = 0; end
if isempty(sigma); sigma = 1; end
if isempty(phase); phase = 0; end
if isempty(L0); L0 = 0.5; end
if isempty(c); c = 1; end
if isempty(xGamma); xGamma = 1; end; 
if isempty(yGamma); yGamma = 1; end;


s = s/2;

% xyGrid = -s:resolution:s;
xyGrid= linspace(-s, s, resolution);
[x,y] = meshgrid(xyGrid, xyGrid);


xTheta = x .* cos(theta) + y .* sin(theta);
% yTheta = -x .* sin(theta) + y .* cos(theta);

v = L0 ... % middle value
    + c .* 0.5 ... %  contrast range
        .* cos( 2. * pi .* f .* ( xTheta ) + phase) ....
        .* exp( -( (x./xGamma).^2 + (y./yGamma).^2 ) / (2.*(sigma.^2)) ) ;

% set those "small differences" from backround luminance as 0 defference
cutoff = c * 0.001;
v(abs(v-L0) < cutoff) = L0;