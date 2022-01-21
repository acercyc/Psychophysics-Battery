function [keyIsDown secs keyName keyCode] = KeyDetector(key)
% [keyIsDown secs keyName keyCode] = KeyDetector(key)
% Detect a certain key or key combination is pressed and return logical
% value
% ***** work with KbName_acer.m to prevent L/R key error******
%
% input: key
% !!!!! The format of input argument 'key' is crucial important!!!!!
% is string >> allow to detect one key
%              ex: key = 'left_control'
%
% is cell including strings >> allow to detect key combination 
%          ex: key = {'left_control' 'right_control'}, press two keys
%          together to trigger action
%
% is cell including cells >> allow to detect multiple key or key
%                            combination
%          ex1: key = {{'left_control' 'right_control'} {'a' 'b'}}
%              press either two controls or 'a and b' to trigger action
%          ex2: key = {{'z'} {'/?'}}
%              press either z or /? to trigger action
%
%   
% 1.0 - Acer 2011/05/25_15:14
% 2.0 - Acer 2011/06/08_17:26

% get key
[keyIsDown secs keyCode] = KbCheck;

keyCode(16:18) = 0; % !!delete ctrl, shift, alt!!
keyName = PsyResp.KbName_acer(keyCode);

if ~keyIsDown
    return
else
    % if allow any key
    if ~exist('key', 'var'); return; end
    if isempty(key); return; end    
    
    keyPressNum = sort(find(keyCode));
    
    % allow key is a string
    if ischar(key)
        keyIsDown = keyMatching(keyPressNum, key);
    end
    
    % cell
    if iscell(key)
        % key combination
        if ischar(key{1})
            keyIsDown = keyMatching(keyPressNum, key);
        
        % Multiple key combination
        elseif iscell(key{1})
            for k_comb_i = 1:length(key)
                keyIsDown = keyMatching(keyPressNum, key{k_comb_i});
                if keyIsDown; return; end
            end
        end
    end
end


function keyIsDown = keyMatching(keyPressNum, key)
    keyNum = sort(PsyResp.KbName_acer(key));
    keyIsDown = isequal(keyPressNum, keyNum);
