function L = fitSechCost(fitWeight,paramVector,paramGuess,paramConfidence)

if paramConfidence<0,
    paramConfidence=0;
elseif paramConfidence>1,
    paramConfidence=1;
end

tmpMin = ones(size(paramVector))./length(paramVector);

minEntropy = -sum(tmpMin.*log(tmpMin));

fitEntropy = minEntropy*(1-paramConfidence);

prior = sech(fitWeight*(paramVector-paramGuess));
prior = prior./sum(prior(:));

estEntropy = -sum(prior.*log(prior));

L = (estEntropy-fitEntropy)*(estEntropy-fitEntropy)';