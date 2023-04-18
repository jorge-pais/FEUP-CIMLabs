% 
% CIM - Trabalho Visual 2
% 
% This function will perform the kMeans algorithm for a given feature and a
% set of staring BG and FG points
%
% Return a binary image of both segments

function segmentedImage = kMeansImage(imageFeature, pointFG, pointBG, iter)
    [H, W] = size(imageFeature, 1:2);
    segmentedImage = uint8(zeros(H, W));

    meanBG = imageFeature(pointBG(1), pointBG(2));
    meanFG = imageFeature(pointFG(1), pointFG(2));

    for iteration = 1:iter
        sumBG = 0; count = 0;
        sumFG = 0;
    
        for i = 1:H
            for j = 1:W
                value = imageFeature(i, j, 1);
                BGdist = abs(value - meanBG);
                FGdist = abs(value- meanFG);
                if BGdist >= FGdist 
                    segmentedImage(i, j) = 255; % Foreground pixel
                    sumFG = sumFG + value;
                else
                    segmentedImage(i, j) = 0; % Background pixel
                    sumBG = sumBG + value;
                    count = count + 1;
                end
            end
        end
        meanBG = sumBG/count;
    end
end