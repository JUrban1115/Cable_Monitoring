% Determine offset in units of bin spacing of curve fit peak from 3 points
% Y values only necessary. x2 is high point
% Uses second order polynomial fit (parabola)

function offset = peakPolyOffset (x1, x2, x3)

[a,b,c] = squareReg(x1,x2,x3); %Find 2nd order coefficients
[root1,root2] = quadForm(a,b,c); %Find parabolic roots

offset = (root1 + root2)/2;

end