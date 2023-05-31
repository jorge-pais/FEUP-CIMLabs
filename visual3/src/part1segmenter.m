%
%   CIM Visual Assignment 3 - Video Shot Detection
%
%   Part 1 - Temporal Segmentation via Image Characteristic Extraction
%   This is the actual function that implements the segmentation algorithms
%   
%   INPUTS:
%       vidObj : <VideoReader>
%       algorithm : <string> algorithm to use. Possible values include 
%        ['luminance', 'spacialActivity', 'ECR', 'colourHistogram'] 
%       threshold : <double> global threshold value to utilize    
%       plot: <Logical> 
%   

function outputFrames = part1segmenter(vidObj, algorithm, threshold, plots)

    %width = vidObj.Width; height = vidObj.Height;
    %colour = strcmp(vidObj.VideoFormat, 'RGB24');

    prevFrame = [];
    outputFrames = [];
    diffValues = []; % Sum of absolute differences

    switch algorithm
    case 'luminance'
        [outputFrames, diffValues] = detectLuminance(vidObj, threshold);
    case 'spacialActivity'
        [outputFrames, diffValues] = detectSpacialActivity(vidObj, threshold);
    case 'ECR'
        [outputFrames, diffValues] = detectEdgeChangeRatio(vidObj, threshold, 3);
    case 'colourHistogram'
        [outputFrames, diffValues] = detectColourHistogram(vidObj, threshold);
    end

    if plots
        figure;
        subplot(2,1,1);
        plot(1:length(diffValues), diffValues);
        title([algorithm, ' frame difference values']);
        xlabel('Frame');
        ylabel('Dists');

        subplot(2,1,2);

        HD = [];
        for i = 1:(length(diffValues)-1)
            HD = [HD, abs(diffValues(i+1) - diffValues(i))];
        end
        plot(1:length(HD), HD)
        title('abs(2nd derivative-ish)');
    end


    % The functions below return the frame numbers where scene changes occur
    function [out, diff] = detectLuminance(video, threshold)
        prevFrame = readFrame(video);
        I_prev = rgb2yuv(prevFrame); Y_prev = I_prev(:,:,1);
        
        out = []; diff = [];

        while hadFrame(video)
            currFrame = readFrame(video);
            currFrameNumber = video.CurrentTime*video.FrameRate;

            I_curr = rgb2yuv(currFrame); Y_curr = I_curr(:,:,1);

            sad = sum(abs(Y_curr - Y_prev), "all");
        
            diff = [diff, sad];
            if sad > threshold
                out = [out, currFrameNumber];
            end

            I_prev = I_curr;
            prevFrame = currFrame;
        end
    end

    function [out, diff] = detectSpacialActivity(video, threshold)
        prevFrame = readFrame(video);
        I_prev = std2(edge(rgb2gray(prevFrame), 'sobel'));
        
        out = []; diff = [];
        
        while hadFrame(video)
            currFrame = readFrame(video);
            currFrameNumber = video.CurrentTime * video.FrameRate;
            
            I_curr = std2(edge(rgb2gray(currFrame), 'sobel'));

            sad = sum(abs(I_curr - I_prev), "all");
        
            diff = [diff, sad];
            if sad > threshold
                out = [out, currFrameNumber];
            end

            I_prev = I_curr;
            prevFrame = currFrame;
        end
    end

    function [out, ecr] = detectEdgeChangeRatio(video, threshold, r)
        prevFrame = readFrame(video);
        out = []; ecr = [];

        while hasFrame(video)
            currFrame = readFrame(video);
            currFrameNumber = video.CurrentTime * video.FrameRate;
            
            bw1 = edge(rgb2gray(currFrame), 'sobel');
            bw2 = edge(rgb2gray(prevFrame), 'sobel');

            s1 = size(find(bw1), 1);
            s2 = size(find(bw2), 1);
            
            % dilate images
            se = strel('square', r); % Structuring Element
            dbw1 = imdilate(bw1, se);
            dbw2 = imdilate(bw2, se);

            imIn = dbw1 & (1 - bw2);
            imOut = dbw2 & (1 - bw1);

            ECRin = size(find(imIn, 1))/s2; ECRout = size(find(imOut), 1)/s1;
            ECR = max(ECRin, ECRout); sad = ECR;

            ecr = [ecr, ECR];

            if ECR > threshold
                out = [out, currFrameNumber];
            end
            
            prevFrame = currFrame;
        end  
    end

    function [out, dists] = detectColourHistogram(video, threshold)

        prevFrame = readFrame(video);
        I_prev = rgb2yuv(prevFrame);
        [prev_count, prev_bins] = imhist(I_prev(:,:,1), 32);

        out = []; dists = [];

        while hasFrame(video)

            currFrame = readFrame(video);
            I_curr = rgb2yuv(currFrame);
            [curr_count, curr_bins] = imhist(I_curr(:,:,1), 32);
            
            currFrameNumber = video.CurrentTime * video.FrameRate;
            
            distance = sqrt(sum((curr_count-prev_count).^2));

            dists = [dists, distance];

            I_prev = I_curr;
            %prevFrame = currFrame;
        end

        HD = []; % take the second derivative
        for k = 2:(length(dists))

            hd = abs(dists(k) - dists(k-1));
            HD = [HD, hd];

            if hd > threshold
                out = [out, k - 1];
            end
        end 
    end
end