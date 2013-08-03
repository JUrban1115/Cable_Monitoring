% [freqList, freqConsistency] = list of freqs and corr. consistencies
% Based on setFreqrRamp, but simplifying for conversion to C for DSP

% adapted to apply 3 point 2nd order polynomial curve fit peak, instead of
% averaged peak. Uses one spectra with fixed number of 2048 samples.
% Outputs peaks from non-overlapping segments of data.
% Specify segment 1,2,3 etc. for 1st, 2nd, 3rd unique segment.

%#eml

function [peakList] = processSCurve3(A,segment) 

%define constants
samplingHz = 100; % Data Sampling Rate (100 for design, 160 for scope)
dataLength = 2048; % Number of time domain samples per run
                   % 2048 for design = 20 sec at 100Hz
                   % 4096 for scope = 25.8 sec at 160Hz

% input data1
data1 = A(1+dataLength*(segment-1):segment*dataLength); % change to data input
spectra1 = generateSpectra(data1,samplingHz);
maxFreq1 = labelMaxFreqs(spectra1);
% make list of peaks found using 3 point 2nd order curve fit
%   in terms of relative bin position.
%   normalize to frequency later.
peakOffsetList = curve3FindPeakOffsets(dataLength/2,spectra1,maxFreq1);

% Bin spacing
binSpacing = samplingHz/dataLength;

% Normalize peaks to freqs
peakList = peakOffsetList.*binSpacing;

end