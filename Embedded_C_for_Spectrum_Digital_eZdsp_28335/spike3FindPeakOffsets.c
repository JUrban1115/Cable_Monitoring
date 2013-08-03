/*
 * spike3FindPeakOffsets.c
 *
 *  Created on: Apr 11, 2010
 *      Author: Jeff
 */
#include "CableMonitoring.h"

// peakList = list of freqs found using spike fit from 3 points inc freqMax

float peakSpikeOffset(int x1,int x2,int x3);

void spike3FindPeakOffsets(){
    // Use curve fit on maximum frequencies, 1 point on either side to find peak
    // Find up to first 50 frequencies (should be enough)
    
    int tempPosition=0; // position in lists of last frequency
    int i;

    for (i=1;i<SPECTRA_LENGTH;i++){ //Cycle through frequency bins in setFreqMax1 (ignore start to consider two rows. Never a frequency in bin 1=0Hz)
        if(freqMax[i]==1){ // if a peak was identified...
            // increment peak counter
            tempPosition = tempPosition + 1;
            if (tempPosition == 50) return; // Maximum number of peaks already reached
            // find peak position in units of bin spacing. Use i + 1 for proper bin ID vs. array indexes
            peakList[tempPosition] = ((float) (i+1)) + peakSpikeOffset(spectraTable[i-1],spectraTable[i],spectraTable[i+1]);
        }
    }
}

