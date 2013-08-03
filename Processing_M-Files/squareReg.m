% Compute y = c + bX + aX(squared) Polynomial regression on 3 points
% code based on
% http://www.mathworks.com/access/helpdesk/help/techdoc/data_analysis/f1-8450.html#f1-7430
% t (freq) values assumed as -1, 0, 1 to give relative position to bin
% output a gives offset of peak from maximum bin
% code tested and confirmed for y = [1,3,2]

function [a,b,c] = squareReg (y1,y2,y3)
% Enter t and y as columnwise vectors
t = [-1 0 1]';
y = [y1 y2 y3]';

% Form the design matrix
X = [ones(size(t))  t  t.*t]; % Make sure this is correct

% Calculate model coefficients
coeffs = X\y;
c = coeffs(1);
b = coeffs(2);
a = coeffs(3);

end