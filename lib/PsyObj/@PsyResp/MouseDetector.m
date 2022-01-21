function [keyIsDown secs buttonNum mousePosition] = MouseDetector(button)
% button: 
% no input variable or emoty >> all you can use
% 1 left button
% 2 middle button
% 3 right button

% 1.0 - Acer 2011/06/21_17:39
% 1.0.1 - Acer 2011/06/21_18:05
% 1.0.2 - Acer 2011/06/21_18:20
secs = GetSecs;
[x y b] = GetMouse;
mousePosition = [x y];
buttonNum = find(b);
if nargin == 0
    keyIsDown = any(b);
elseif isempty(button)
    keyIsDown = any(b);
else
    if find(b) == button; keyIsDown = 1; else keyIsDown = 0; end
end