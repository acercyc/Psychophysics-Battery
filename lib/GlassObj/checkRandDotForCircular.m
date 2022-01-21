function dots = checkRandDotForCircular(dots, d, canvasRange)
%======================================================================%
% Replace dot within -d to d range by other dots outside the range
% The dot coordinate is the original one
% 1.0 - Acer 2013/10/06 18:12
%======================================================================%

while 1
   dd = eulaDist(dots(:,1), dots(:,2), canvasRange(1)/2, canvasRange(2)/2);
   idx = find(dd <= d);
   if isempty(idx)
       break
   else
       dotsRep = randDotGen(numel(idx), canvasRange); 
       dots(idx, :) = dotsRep;
   end
end
