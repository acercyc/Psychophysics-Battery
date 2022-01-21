function p=marginalize(p,pDims)

tmpP = p;
for n=1:length(pDims),
    tmpP = (sum(tmpP,pDims(n)));
end
p=squeeze(tmpP);

