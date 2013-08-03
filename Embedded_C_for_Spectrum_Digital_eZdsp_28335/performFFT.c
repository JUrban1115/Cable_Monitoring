#include "FPU.h"	// for FFT functions
#include "IQmathLib.h"	// for FFT functions
#include "CableMonitoring.h"	// project variable structure definitions

/* Align the INBUF section to 2*FFT_SIZE in the linker file if using RFFT_f32 */

float32 OutBuffer[DATA_LENGTH];
float32 TwiddleBuffer[DATA_LENGTH];
RFFT_F32_STRUCT fft;

void performFFT()
{
	fft.InBuf = SampleTable; /* Input data buffer */
	fft.OutBuf = OutBuffer; /* FFT output buffer */
	fft.CosSinBuf = TwiddleBuffer; /* Twiddle factor buffer */
	fft.FFTSize = DATA_LENGTH; /* FFT length */
	fft.FFTStages = FFT_STAGES; /* FFT Stages */
	fft.MagBuf = spectraTable; /* Magnitude buffer */
	RFFT_f32_sincostable(&fft); /* Initialize Twiddle Buffer */
	RFFT_f32u(&fft); /* Calculate output */
	RFFT_f32_mag(&fft); /* Calculate magnitude */
}
