% [freqList, freqConsistency] = list of freqs and corr. consistencies
% Based on setFreqrRamp, but simplifying for conversion to C for DSP

% adapted to apply 3 point equilateral triangle fit peak, instead of
% averaged peak. Uses one spectra from beginning of array A to length
% 'dataLength'.

%#eml

function [peakList] = processLSpike3(A,dataLength) 

%define constants
samplingHz = 100; % Data Sampling Rate (100 for design, 160 for scope)

data1 = A(1:dataLength); % change to data input
spectra1 = generateSpectra(data1,samplingHz);
maxFreq1 = labelMaxFreqs(spectra1);
% make list of peaks found using 3 point 2nd order curve fit
%   in terms of relative bin position.
%   normalize to frequency later.
peakOffsetList = spike3FindPeakOffsets(dataLength/2,spectra1,maxFreq1);

% Bin spacing
binSpacing = samplingHz/dataLength;

% Normalize peaks to freqs
peakList = peakOffsetList.*binSpacing;

end