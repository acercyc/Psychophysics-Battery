% For linear fade in and fade ou
% output = SoundFade(sData, SF, secs [, ydb])
%   ydb can be omitted for initial value = -300
% 1.0 - Acer 2010/8/14
% 1.1 - Acer 2010/10/07
%   fix SF*secs has fraction part

function output = SoundFade(sData, SF, secs, ydb)
if nargin < 4
    ydb = -300;
end

% parameters calculation
PointNum =  SF * secs;
PointNum = round(PointNum);
weakPoint = db2mag(ydb);

% check Sound length > fade length
if PointNum*2 > length(sData)
    error('Sound length < fade length');
end

% calcuating applyArray
applyArray = linspace(weakPoint, 1, PointNum);
middleOne = ones(1,length(sData) - PointNum*2);
applyArray = [applyArray middleOne fliplr(applyArray)];

output = sData .* applyArray;


