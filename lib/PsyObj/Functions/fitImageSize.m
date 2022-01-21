function [imgSizeNew, dim] = fitImageSize(sizeOrig, sizeTarget)
% imgSizeNew = fitImageSize(sizeOrig, sizeTarget)
%----------------------------------------------------------------------

ratio = sizeTarget ./ sizeOrig;
[mRatio, dim] = min(ratio);
imgSizeNew = sizeOrig .* mRatio;