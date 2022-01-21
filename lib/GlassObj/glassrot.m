function g = glassrot(mp, image, N)
%	mp is an array containing a micropattern, image is an array that should initially be
%	filled with zeros, N is the number of dipole dots in the display 

d=200; %d=distance
sep=300;%higher number greater dipole separation
for i = 1:N,
psize = size(mp);
isize = size(image);

mph = psize(1);
mpw = psize(2);
imh = isize(1);
imw = isize(2);


rad=sqrt(rand(1))*d; 
theta=rand(1)*360;

for i=1:2
if i==2
theta=theta+(1/rad)*sep;
end


[x,y] = RotateXY(rad, 0, theta);
x = x + length(image)/2 - length(mp)/2 + 1; y = y + length(image)/2 - length(mp)/2 + 1;
row=x;
col=y;

image(row:row+mph-1, col:col+mpw-1) = image(row:row+mph-1, col:col+mpw-1)+mp;

end

end