/*
 * processLSpike3.c
 *
 *  Created on: Apr 11, 2010
 *      Author: Jeff
 */
#include "CableMonitoring.h"
 
void generateSpectra();
void labelMaxFreqs();
void spike3FindPeakOffsets();


void processLSpike3(){
	float binSpacing;
	int i;
	    
	generateSpectra();

	labelMaxFreqs();

	spike3FindPeakOffsets();

	binSpacing = ((float) SAMPLING_HZ)/((float) DATA_LENGTH);

	// Normalize peaks to freqs
	for (i=0;i<50;i++){
		peakList[i] *= binSpacing;
	}
}
