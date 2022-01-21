function logCSF = findQCSF(FREQ,logGain,logCenter,octaveWidth,logTrunc)
% logCSF = findQCSF(FREQ,logGain,logCenter,octaveWidth,logTrunc)
%

linTrunc=10.^logTrunc;

tauDecay = .5;
K = log10(tauDecay);
logWidth = [(10.^octaveWidth).*log10(2)]./2;

logP = logGain + K.*[(1./logWidth).*(FREQ - logCenter)].^2;

truncHalf = logGain - linTrunc;

leftCSF = [(logP < truncHalf) & (FREQ < logCenter)].*truncHalf;
rightCSF = [(logP >= truncHalf) | (FREQ > logCenter)].*logP;

logCSF = (leftCSF + rightCSF);
logCSF(find(logCSF<0))=0;