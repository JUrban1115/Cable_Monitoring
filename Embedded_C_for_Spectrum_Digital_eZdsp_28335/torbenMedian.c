#include "CableMonitoring.h"

/*
* The following code is public domain.
* Algorithm by Torben Mogensen, implementation by N. Devillard.
* This code in public domain.
*/
float torbenMedian()
{
int i, less, greater, equal;
float min, max, guess, maxltguess, mingtguess;
min = max = spectraTable[0] ;
for (i=1 ; i<SPECTRA_LENGTH ; i = i + 1) {
if (spectraTable[i]<min) min=spectraTable[i];
if (spectraTable[i]>max) max=spectraTable[i];
}
while (1) {
guess = (min+max)/2;
less = 0; greater = 0; equal = 0;
maxltguess = min ;
mingtguess = max ;
for (i=0; i<SPECTRA_LENGTH; i++) {
if (spectraTable[i]<guess) {
less++;
if (spectraTable[i]>maxltguess) maxltguess = spectraTable[i] ;
} else if (spectraTable[i]>guess) {
greater++;
if (spectraTable[i]<mingtguess) mingtguess = spectraTable[i] ;
} else equal++;
}
if (less <= (SPECTRA_LENGTH+1)/2 && greater <= (SPECTRA_LENGTH+1)/2) break ;
else if (less>greater) max = maxltguess ;
else min = mingtguess;
}
if (less >= (SPECTRA_LENGTH+1)/2) return maxltguess;
else if (less+equal >= (SPECTRA_LENGTH+1)/2) return guess;
else return mingtguess;
}
