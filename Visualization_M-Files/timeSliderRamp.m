% Script to generate 3D plot of ramped spectra over time, 2D plot of
% identified peak locations, and matrix of identified peaks.

% Modification of timeSliderAdjConMiddleHigh.m to scale peak heights
% linearly with frequency, to give more even heights and level of
% jaggedness (noise) to graphs. Identifies peaks in over 50% of adjoining
% bin pairs and averages bin location to report peak. Simpler,
% non-averaging method is commented out.

% Combines plot towers, plot consecutives code with timeSliderAdjustable
% Identifies highest point in each series. Commented out sections that
% limit to consecutive series. 

%Steps:
% 1. Load dataset
% 2. Specify powerOf2 for time-domain segment lengths.
%                      8->256 (62 traces / 1.6 sec at 160Hz), 
%                      10->1024 (15 traces / 6.5 sec),
%                      12->4096 (3 traces / 26 sec)
% 3. Run this code

timeSlide=[]; %2D Array to hold frequency spectras
timeSlideMax=[]; %2D Array to hold maximum frequencies
timeSlideMax1=[]; %2D Array to hold max frequencies as value 1 
numSets=floor(Length/(2^powerOf2)); 
    % determine number of complete subsets of data
for subset=1:numSets, % take subsets in time from data
   tempSet=A(1+2^powerOf2*(subset-1):2^powerOf2*(subset));
   % take subsets of data for spectral analysis
   % these subsets are unique but connected end to end
   
    [Xsize,Ysize]=size(tempSet);
    t_sample=Tinterval*Xsize;
    t1=((1/Xsize):(t_sample/Xsize):t_sample);

    %Taking the Fourier Transform of input data
    Fs=1/Tinterval;
    Ts=Tinterval;
    t2=0:Ts:t_sample-Ts;
    n=length(t2);
    y=tempSet;

    [YfreqDomain,frequencyRange]=positiveFFT(y,Fs);

    YfreqDomain = abs(YfreqDomain);
    YfreqRamp = YfreqDomain;
    
    %Scale heights linearly with frequency
    for i=1:size(YfreqRamp),
        YfreqRamp(i)=(i*YfreqDomain(i));
    end
    
    %Peak locating code goes here:
    
    % Generate towers from spectra

    OverNum = 4*median(YfreqRamp);
    %Changed from 'mean' to avoid undue influence from high amplitude 
    % elements
    YfreqOver = YfreqRamp >= OverNum;

    YfreqOver2=zeros(numel(YfreqRamp),1);
 
    % Optionally, save only consecutive points from YfreqOver
%     for i=2:numel(YfreqOver)-1, %@@@@@ ignoring first and last points
%         if ((YfreqOver(i-1) == 1) && ((YfreqOver(i-1) == 1) 
%                 || (YfreqOver(i+1) == 1))), 
%                % point is consecutive to other points
%             YfreqOver2(i)=YfreqOver(i);
%         end
%     end
%     
    YfreqOver2=YfreqOver; % remove if uncommenting above
    
    YfreqSquish2 = YfreqRamp.*YfreqOver2;
    
    %End of peak locating code
    
    %Find peak point
    YfreqMax = zeros(numel(YfreqSquish2),1); %record max frequencies
    YfreqMax1 = zeros(numel(YfreqSquish2),1); %record high frequencies as 1
    newPeak = 0; % flag for new peak (consecutive sequence)
    highestPoint = 0; % temp variable for highest peak point
    for i=2:numel(YfreqOver2)-1, %@@@@@ ignoring first and last points
        if (YfreqOver2(i) == 1), %In a peak
            if (newPeak == 0), %Peak is new
                newPeak = 1; %peak found
                highestPoint = (i);
            else %Peak continues
                if (YfreqSquish2(i) > YfreqSquish2(highestPoint)),
                    highestPoint = i;
                end
            end
        else
            if (newPeak == 1), %Peak has ended
                YfreqMax1(highestPoint) = 1;
            end
            newPeak = 0; %No Longer in a peak
            highestPoint = 0;
        end
    end

    YfreqMax=YfreqMax1.*YfreqSquish2; % Record high frequency values
    
    timeSlide=[timeSlide,YfreqRamp];
    timeSlideMax=[timeSlideMax,YfreqMax];
    timeSlideMax1 =[timeSlideMax1,YfreqMax1];
end

% Optionally, take only a portion of the spectra
% timeSlideMax1P=timeSlideMax1(1:2^(powerOf2-2),:);
% timeSlideP=timeSlide(1:2^(powerOf2-2),:); % lower 1/2 of graph

% Take entire Spectra
timeSlideMax1P=timeSlideMax1;
timeSlideP=timeSlide; % lower 1/2 of graph

figure;

%subplot(1,2,1);
colormap(hsv);
surf(timeSlideP); %3D plot of timeSlide
campos([130.9283  120.2973    0.1429]);

figure
%subplot(1,2,2);
peakGraph = imshow(timeSlideMax1P'); %2D plot of peaks

% Simpler, non-averaging method to report frequencies
% for timeSlideMax1P, cycle up frequencies. If frequency reported 1/2 of
% time or more, reference value at same index in frequencyRange and add to
% listing of frequencies.

% %Considering a single bin at a time
% [numBins,numSpectra]=size(timeSlideMax1P);
% freqList=[]; %Initialize array to hold found frequencies
% for i=1:numBins, %Cycle through frequency bins in timeSlideMax1P
%     tempValue = 0; %Count frequency of found peak
%     for j=1:numSpectra,
%         tempValue = tempValue + timeSlideMax1P(i,j); 
%            %Count instances at each freq bin
%     end
%     if (tempValue > floor(numSpectra/2)),
%         freqList = [freqList,frequencyRange(i)]; 
%            %If above 50% of spectra have peak, record freq
%     end
% end
% sampleLength = 2^powerOf2/160
% numSpectra
% binWidth = frequencyRange(2)
% freqList % report frequencies found

% Average consecutive bins to find more freqs and more accurately
% predict frequency
[numBins,numSpectra]=size(timeSlideMax1P);
freqList=[]; %Initialize array to hold found frequencies
freqStrength=[]; %Initialize array to hold frequency strengths (instances)
tempValue1 = 0; %Count frequency of found peak in previous row
tempValue2 = 0; %Count frequency of found peak in current row
tempTotal = 0; %Count frequency of found peaks in prev+current row
foundPeak = 0; %Record if peak identified in current row
for i=2:numBins, %Cycle through frequency bins in timeSlideMax1P 
    % (ignore start to consider two rows. Never a frequency in bin 1=0Hz)
    tempValue1 = tempValue2; %shift previous row
    tempValue2 = 0; %Count frequency of found peak in current row
    for j=1:numSpectra,
        tempValue2 = tempValue2 + timeSlideMax1P(i,j); 
        %Count instances at current freq bin
    end
    if ((tempValue1+tempValue2) > floor(numSpectra/2)), 
        %If over 50% of spectra have peak in either bin (no one spectra may
        % have adjoining peaks, so no double counting here)
        if (tempValue1+tempValue2) > tempTotal, 
            %tempTotal is from previous bin. Record if more points in these
            % two bins, than in last two.
            if (~foundPeak), % Not 2nd bin in a row identified 
                % (check foundPeak from previous row)
                freqList = [freqList,(frequencyRange(i-1)*tempValue1+frequencyRange(i)*tempValue2)/(tempValue1+tempValue2)]; %Record frequency, weighted across 2 bins
                freqStrength = [freqStrength, tempValue1+tempValue2]; 
                %Record number of points for this freq.
            else
                % 2nd bin in a row identified,
                % this one should overwrite previous
                freqList(numel(freqList)) = (frequencyRange(i-1)*tempValue1 + frequencyRange(i)*tempValue2)/(tempValue1+tempValue2); 
                    %Record frequency, weighted across 2 bins.
                    % Delete previous entry, since this one is improved.
                freqStrength(numel(freqStrength)) = (tempValue1+tempValue2);
                    %Reocrd number of points for this freq. Delete previous
                    %since this is improved.
            end
        end
        foundPeak=1; % flag peak found in this bin
    else
        foundPeak=0; % flag peak not found in this bin
    end
    tempTotal=tempValue1+tempValue2; %update total count for current bin
end
% Need to pick better result if identified in two consecutive bins
sampleLength = 2^powerOf2/160
numSpectra
binWidth = frequencyRange(2)
freqMatrix=[]; %array to hold freqs and strengths
for i=1:numel(freqList),
    freqMatrix=[freqMatrix; freqList(i) freqStrength(i)];
    % report frequencies found
end
freqMatrix