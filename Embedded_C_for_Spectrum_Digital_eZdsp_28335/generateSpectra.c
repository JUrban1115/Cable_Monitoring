/*
 * generateSpectra.c
 *
 *  Created on: Apr 11, 2010
 *      Author: Jeff
 */
 #include "CableMonitoring.h"

// freqDomain = fft with linear ramp


void performFFT();

void generateSpectra() {
	int i;
	
    //Taking the Fourier Transform of input data
    performFFT(); // Perform FFT

    //Scale heights linearly with frequency
    for (i=0;i<SPECTRA_LENGTH;i++)
    {
        spectraTable[i]=i*(spectraTable[i]);
    }
}
