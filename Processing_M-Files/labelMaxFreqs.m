% YfreqMax = array, same length of YfreqDomain with 1 or 0 to ID peaks
% Peaks are denoted as 1.

%#eml

function YfreqMax = labelMaxFreqs (YfreqDomain)
    OverNum = 4*median(YfreqDomain); % Set cutoff for peak ID

    YfreqOver = YfreqDomain >= OverNum; % returns 1 or 0 to form over/under array
    
    %Find peak point
    YfreqMax = zeros(length(YfreqDomain),1); %record high frequencies as 1
    newPeak = 0; % flag for new peak (consecutive sequence)
    highestPoint = 0; % temp variable for highest peak point
        
    for i=2:numel(YfreqOver)-1, %@@@@@ ignoring first and last points
        if (YfreqOver(i) == 1), %In a peak
            if (newPeak == 0), %Peak is new
                newPeak = 1; %peak found
                highestPoint = (i);
            else %Peak continues
                if (YfreqDomain(i) > YfreqDomain(highestPoint)),
                    highestPoint = i;
                end
            end
        else
            if (newPeak == 1), %Peak has ended
                YfreqMax(highestPoint) = 1;
            end
            newPeak = 0; %No Longer in a peak
            highestPoint = 0;
        end
    end
end
