% YfreqDomain = Positive, real fft

%#eml

function freqDomain = positiveFFT(x,Fs)
N=length(x); %get the number of points
X=fft(x)/N; % normalize the data

%only want the first half of the FFT, since it is redundant
cutOff = ceil(N/2);

%take only the first half of the spectrum
freqDomain = X(1:cutOff);
end