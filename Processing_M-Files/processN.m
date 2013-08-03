% [freqList, freqConsistency] = list of freqs and corr. consistencies
% Based on setFreqrRamp, but simplifying for conversion to C for DSP

% This code is adjusted for 100Hz sampling rate

%#eml

function [freqList, freqConsistency] = processN(A,n) 

%define constants
samplingHz = 100; % Data Sampling Rate (100 for design, 160 for scope)
dataLength = 2048; % Number of time domain samples per run
                   % 2048 for design = 20 sec at 100Hz
                   % 4096 for scope = 25.8 sec at 160Hz
numSpectra = n;
setFreqMax1=[];

for i=1:n,
% input data
data = A(dataLength*(i-1)+1:i*dataLength); % change to data input
spectra = generateSpectra(data,samplingHz);
maxFreq = labelMaxFreqs(spectra);

% Save YfreqMax values from each subSet for later use
setFreqMax1 = [setFreqMax1, maxFreq];
end

frequencyRange = freqRange(dataLength,samplingHz);

% to cut off frequency spectra above a certain frequency
% for example, (1:2^(powerOf2-2),:) limits us to about 28Hz at 160Hz
% should not be necessary if using 100Hz input
% setFreqMax1=setFreqMax1(1:2^(powerOf2-2),:);

[freqList,freqConsistency] = listPeaks(dataLength/2,numSpectra,setFreqMax1, frequencyRange);

end