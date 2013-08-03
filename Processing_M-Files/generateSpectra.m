% YfreqDomain = fft with linear ramp

%#eml

function YfreqDomain = generateSpectra(timeDomain, samplingHz) 
      
    %Taking the Fourier Transform of input data
    YfreqDomain=positiveFFT(timeDomain,samplingHz); % Perform FFT
    YfreqDomain = abs(YfreqDomain); % Convert from complex to real
    
    %Scale heights linearly with frequency
    for i=1:length(YfreqDomain),
        YfreqDomain(i)=(i*YfreqDomain(i));
    end
end