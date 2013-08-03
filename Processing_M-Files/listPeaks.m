% [freqList, freqConsistency] = lists of freqs and freq consistency
% This function outputs a list of frequencies weighted by the number of
% times identified in each frequency bin.
% Inputs are number of FFT bins, number of FFTs, array of maximum points,
% frequencies for each bin.
% Outputs are a list of peak frequencies identified and the number of times
% identified.

%#eml

function [freqListOut, freqConsistencyOut] 
    = listPeaks (fftSize, numSets, setFreqMax1, frequencyRange)

% average consecutive bins to find more freqs and more accurately
% predict frequency
% Find up to first 50 frequencies (should be enough)
freqList=zeros(50); %Initialize array to hold found frequencies
%Initialize array to hold frequency consistency (instances)
freqConsistency=zeros(50); 
tempPosition=0; % position in lists of last frequency
tempValue2 = 0; %Count frequency of found peak in current row
tempTotal = 0; %Count frequency of found peaks in prev+current row
foundPeak = 0; %Record if peak identified in current row
for i=2:fftSize, %Cycle through frequency bins in setFreqMax1 
    %(ignore start to consider two rows. Never a frequency in bin 1=0Hz)
    tempValue1 = tempValue2; %shift previous row
    tempValue2 = 0; %Count frequency of found peak in current row
    for j=1:numSets,
         %Count instances at current freq bin
        tempValue2 = tempValue2 + setFreqMax1(i,j);
    end
    if ((tempValue1+tempValue2) > floor(numSets/2)), 
        %If over 50% of spectra have peak in either bin (no one spectra may
        %have adjoining peaks, so no double counting here)
        if (tempValue1+tempValue2) > tempTotal, 
            %tempTotal is from previous bin. Record if more points in these
            %two bins, than in last two.
            if (~foundPeak), % Not 2nd bin in a row identified 
                %(check foundPeak from previous row)
                tempPosition = tempPosition + 1;                
                freqList(tempPosition) 
                    = (frequencyRange(i-1)*tempValue1
                    +frequencyRange(i)*tempValue2)/(tempValue1+tempValue2);
                    %Record frequency, weighted across 2 bins
                freqConsistency(tempPosition) = tempValue1+tempValue2; 
                    %Record number of points for this freq.
            else % 2nd bin in a row identified, 
                %this one should overwrite previous
                freqList(tempPosition) 
                    = (frequencyRange(i-1)*tempValue1
                    +frequencyRange(i)*tempValue2)/(tempValue1+tempValue2); 
                    %Record frequency, weighted across 2 bins. 
                    %Delete previous entry, since this one is improved.
                freqConsistency(tempPosition) = (tempValue1+tempValue2);
                    %Record number of points for this freq. 
                    %Delete previous since this is improved.
            end
        end
        foundPeak=1; % flag peak found in this bin
    else
        foundPeak=0; % flag peak not found in this bin
    end
    tempTotal=tempValue1+tempValue2; %update total count for current bin
end
% remove trailing zeros in freqList, freqConsistency
freqListOut = freqList(1:tempPosition);
freqConsistencyOut = freqConsistency(1:tempPosition);
end