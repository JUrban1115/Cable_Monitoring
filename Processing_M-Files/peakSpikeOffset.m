% Determine offset in units of bin spacing of spike fit peak from 3 points
% Y values only necessary. x2 is high point
% Uses largest equilateral triangle under peak and two neighbors.

function offset = peakSpikeOffset (x1, x2, x3)
% x1,x2,x3 are y coordinate at -1,0,1 vs high point identified
% fit line b/w center and lowest points, find x coordinate of intercept 
% with opposite slope line through remaining point
if (x1 < x3) 
    offset = 0.5*(x3-x1)/(x2-x1);

else 
    offset = 0.5*(x1-x3)/(x3-x2);
end
% offset is location of peak top relative to high point in units of bin
% spacing

end