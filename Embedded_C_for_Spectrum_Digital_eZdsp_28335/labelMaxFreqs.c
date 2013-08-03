/*
 * labelMaxFreqs.c
 *
 *  Created on: Apr 11, 2010
 *      Author: Jeff
 */
 #include "CableMonitoring.h"

// freqMax = array, same length of freqDomain with 1 or 0 to ID peaks

float torbenMedian();

void labelMaxFreqs(){
	float OverNum;
    int i;
    int newPeak = 0;
    int highestPoint = 0; // temp variable for highest peak point
    
	OverNum = torbenMedian();
	OverNum *= 4; // Set cutoff for peak ID

    for(i=0;i<SPECTRA_LENGTH;i++){
        if(spectraTable[i] >= OverNum){
            freqOver[i] = 1; // returns 1 or 0 to form over/under array
        }
        else{
            freqOver[i] = 0;
        }
    }
    
    //Find peak point

	//@@@@@ ignoring first and last points to ensure neighbors
    for (i=1;i<SPECTRA_LENGTH-1;i++){
		if (freqOver[i] == 1){ //In a peak
            if (newPeak == 0){ //Peak is new
                newPeak = 1; //peak found
                highestPoint = i;
            }
            else {//Peak continues
                if (spectraTable[i] > spectraTable[highestPoint]){
                    highestPoint = i;
                }
            }
		}
		else {
            if (newPeak == 1){ //Peak has ended
                freqMax[highestPoint] = 1;
            }
            newPeak = 0; //No Longer in a peak
            highestPoint = 0;
		}
    }
}
