%
%   CIM Visual Assignment 3 - Video Shot Detection
%
%   Part 1 - Temporal Segmentation via Motion Estimation
%
clear; close all;
INPUT_FILE = "../videoSequences/wg_cs_1.mpg";
OUTPUT_FILE = "../results/output";
TIME_PER_FRAME = 0.5; 

MB_SIZE = 16;
max_motion_displacement = 32;

input_video = VideoReader(INPUT_FILE);

%  for now let's process every image as B&W
prev_frame = readFrame(input_video);
prev_frame = rgb2gray(prev_frame);

% Probably should pad every frame of the video, but for now the macro block size is constant
while hasFrame(input_video)
    curr_frame = readFrame(input_video);
    curr_frame = rgb2gray(curr_frame);

    motion_vec = threeStepSearch(prev_frame, curr_frame, MB_SIZE, max_motion_displacement);

    %figure(1); imshow(curr_frame);

    figure(2);
    plot_MV_function(input_video.Height, input_video.Width, MB_SIZE, motion_vec(:,:,1), motion_vec(:,:,2));

    pause
end

function motion_vectors = threeStepSearch(refFrame, currFrame, mbSize, motionDisplacement)

    [height, width] = size(currFrame);

    motion_vectors = zeros(floor(height/mbSize), floor(width/mbSize), 2);

    predMV = zeros(2);

    % iterate through the image macroblocks
    for i = 1:mbSize:height % H
        for j = 1:mbSize:width % W
            bestMV = zeros(2); minSad = inf;

            % get the macroblock
            currBlock = currFrame(i:(i + mbSize - 1), j:(j + mbSize - 1));

            predMV(1) = 0 + i - 1; 
            predMV(2) = 0 + j - 1;
            
            stepSize = motionDisplacement;
            
            while stepSize >= 1
                for dx = -stepSize : stepSize : stepSize
                    for dy = -stepSize : stepSize : stepSize
                        % motion vetor
                        mvX = predMV(1) + dx;
                        mvY = predMV(2) + dy;

                        % Check if the macroblock is within range
                        if mvX >= 1 && mvX + mbSize - 1 < height && mvY >=1 && mvY + mbSize - 1 <= width
                            refBlock = refFrame(mvX : mvX + mbSize - 1, mvY : mvY + mbSize - 1);

                            sad = sum(abs(currBlock - refBlock), "all");

                            if(sad < minSad)
                                minSad = sad;
                                bestMV = [(mvX-i+1) (mvY-j+1)];
                            end
                        end
                    end
                    stepSize = stepSize / 2;
                end
            end
            motion_vectors(floor(i/mbSize + 1), floor(j/mbSize + 1), :) = bestMV;
        end
    end
end

% Returns the sum of absolute differences between input1 and input2
function out = calcSAD(input1, input2)

    colour = (length(size(input1)) == 3);

    if colour
        I1 = rgb2yuv(input1); I2 = rgb2yuv(input2);

        sadY = sum(abs(I1(:,:,1)-I2(:,:,1)), "all");
        sadU = sum(abs(I1(:,:,2)-I2(:,:,2)), "all");
        sadV = sum(abs(I1(:,:,3)-I2(:,:,3)), "all");

        % out = sadY;

        out = (sadY * sadU * sadV)^1/3; % Do the geometric mean, that might mean something
    else
        out = sum(abs(input1, input2), "all");
    end
end
