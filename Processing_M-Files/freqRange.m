%freqRange = array of freqs corresponding to fft bins

%#eml

function freqRange = freqRange(fftBins,samplingHz)

N=fftBins; %get the number of points
k=0:N-1;     %create a vector from 0 to N-1
T=N/samplingHz;      %get the frequency interval
freq=k/T;    %create the frequency range

%only want the first half of the FFT, since it is redundant
cutOff = ceil(N/2);

%take only the first half of the spectrum
freqRange = freq(1:cutOff);
end