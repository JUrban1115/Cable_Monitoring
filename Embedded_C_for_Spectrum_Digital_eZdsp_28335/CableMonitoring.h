#include "DSP28x_Project.h"     // Device Headerfile and Examples Include File
#ifndef CABLEMONITORING_H_
#define CABLEMONITORING_H_

// define constants
#define		SAMPLING_HZ			100		// sampling frequency
#define		DATA_LENGTH 		2048	/* 32, 64, 128, 256, etc */
#define		FFT_STAGES 			11		/* log2(DATA_LENGTH) */
#define		SPECTRA_LENGTH		1024	// Half of input data length

// define structures
typedef struct {
  Uint16 data[2048];
} DataBuffStruct;

typedef struct {
  float32 spectra[1024];
} SpectraBuffStruct;

extern   float32 SampleTable[DATA_LENGTH];
extern   float32 spectraTable[SPECTRA_LENGTH];
extern   Uint16 freqMax[SPECTRA_LENGTH];
extern   Uint16 freqOver[SPECTRA_LENGTH];
extern   float32 peakList[50];

#endif /*CABLEMONITORING_H_*/
