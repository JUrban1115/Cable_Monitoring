% peakList = list of freqs found using curve fit from 3 points inc maxFreq

%#eml

function peakList = spike3FindPeakOffsets(fftSize,spectra,maxFreq)

    % Use curve fit on maximum frequencies, 
    % 1 point on either side to find peak
    % Find up to first 50 frequencies (should be enough)
    peakList = [];
    peakList1=zeros(50); %Initialize array to hold found frequencies
    tempPosition=0; % position in lists of last frequency

    for i=2:fftSize, %Cycle through frequency bins in setFreqMax1 
        %(ignore start to consider two rows. Never a frequency in bin 1=0Hz)
        if(maxFreq(i)==1), % if a peak was identified...
            % increment peak counter
            tempPosition = tempPosition + 1;
            % find peak position in units of bin spacing
            peakList1(tempPosition) = i 
                + peakSpikeOffset(spectra(i-1),spectra(i),spectra(i+1));
        end
    end
    if (tempPosition ~= 0),
        % remove trailing zeros in freqList, freqConsistency
        peakList = peakList1(1:tempPosition);
    end
end