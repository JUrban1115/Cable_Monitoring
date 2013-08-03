/*
 * peakSpikeOffset.c
 *
 *  Created on: Apr 11, 2010
 *      Author: Jeff
 */

// Determine offset in units of bin spacing of spike fit peak from 3 points
// Y values only necessary. x2 is high point

float peakSpikeOffset(int x1,int x2,int x3){
	// x1,x2,x3 are y coordinate at -1,0,1 vs high point identified
	// fit line b/w center and lowest points, find x coordinate of intercept
	// with opposite slope line through remaining point
	float offset;
	
	if (x1 < x3){
		offset = 0.5*((float) (x3-x1)/(x2-x1));
	}
	else {
		offset = 0.5*((float) (x1-x3)/(x3-x2));
	}
	// offset is location of peak top relative to high point in units of bin
	// spacing
	return offset;
}

