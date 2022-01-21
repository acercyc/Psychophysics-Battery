%======================================================================%
% QuitPsych(key)
% Quit Psychtoolbox (co-operate with try-catch statement)
% key: key combination for quittin
%   Please use {} to defind multiple keys
%   default: {'control' 'alt' 'p'}
%   
% 2.0 - Acer 2011/05/04_18:03
%======================================================================%
function QuitPsych(key)

% defind correct keys
if ~exist('key', 'var')
    keyNum = KbName({'control' 'alt' 'p'}); % default
else
    keyNum = KbName(key);
end
keyNum = unique(keyNum);
    
% get real pressed keys
[keyIsDown key_down_time keyCode] = KbCheck;
keyPressNum = find(keyCode);

if keyIsDown && all(ismember(keyNum, keyPressNum));
    error('abort program');
end
