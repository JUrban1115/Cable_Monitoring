% freqMatrix=peakTracker(A,dataLength,stride, percent)
% Processes 'sliding window' for FFT over time.
% Outputs lists of Identified frequencies sorted into vertical columns.
% Each column contains frequencies within 0.1Hz windows.
% A is the input matrix, dataLength is the number of samples to consider
% at a time. Stride is the number of samples to increment between FFTs.
% Percent is the minimum percentage of FFTs reporting a frequency within
% that particular 0.1Hz frequency range.

function [freqMatrix] = peakTracker(A,dataLength,stride, percent)

peakMatrix = zeros(1,40);
% freqMatrix = zeros(ceil(length(A)/dataLength),100);
% peakMatrix = [];
freqMatrix = [];


% Make matrix of peaks
for i=1:stride:length(A)-dataLength % Cycle through all starting points
    newFreqs = processLSpike3(A(i:length(A)),dataLength);
    peakMatrix = [peakMatrix; newFreqs, zeros(1,40-length(newFreqs))]; 
    % Generate matrix with lists of peaks in rows
end

% Take minimum value and return list of similar values with row ID
c = 1; % column of freqMatrix
freqMatrix = zeros(size(peakMatrix,1),100);
while any(peakMatrix(:,1)) || any(peakMatrix(:,2)) % while there are non-zero values
    % remove all leading zeros
    for j=1:size(peakMatrix,1) % cycle through rows
        if peakMatrix(j,1) == 0 % leading zero in line
            peakMatrix=shiftl(peakMatrix,j,1); % shift with 0 replace
        end
    end
    
    minVal = min(setdiff(peakMatrix(:,1),0)); % minimum non-zero
    for j=1:size(peakMatrix,1) % cycle through rows
%        if minVal == 0, end % ignore zeros
        if peakMatrix(j,1) < minVal + 0.1 % find, record, delete close values
            freqMatrix(j,c)=peakMatrix(j,1); % save value
            peakMatrix(j,1) = 0; % erase saved value
        end
    end
    c=c+1; %increment to next column in freqMatrix
end

% Remove zero columns from freqMatrix
freqMatrix = freqMatrix(:,1:c-1); %delete extra rows

% For rare frequencies < 75%, change to zero to reduce data
finished = 0;
thisCol = 1;
while ~finished % cycle through columns
    if mean(freqMatrix(:,thisCol))<(0.01*percent*max(freqMatrix(:,thisCol)))
        freqMatrix(:,thisCol) = []; % delete column, continue with same col #
    else
        thisCol = thisCol+1; % if not deleting, increment col #
    end
    if thisCol > size(freqMatrix,2) % no more columns
        finished = 1;
    end
end

end