% Find 2 roots given 3 polynomial coefficients
% Based on code from http://www.tufts.edu/~rwhite07/Matlab.html

function [root1, root2] = quadForm (a,b,c)
% Different cases for A=0 and otherwise
if a==0,
    x=-c/b;
else
    root1 = (-b+sqrt(b^2-4*a*c))/(2*a);
    root2 = (-b-sqrt(b^2-4*a*c))/(2*a);
end