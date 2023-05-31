%
%   CIM Visual Assignment 3 - Video Shot Detection
%
%   Part 1 - Temporal Segmentation via Motion Estimation
%
clear; close all;
INPUT_FILE = "../videoSequences/wg_cs_1.mpg";
OUTPUT_FILE = "../results/output";
TIME_PER_FRAME = 0.5; 

MB_SIZE = 8;
max_motion_displacement = 4;

input_video = VideoReader(INPUT_FILE);

inHeight = input_video.Height; inWidth = input_video.Width;

%  for now let's process every image as B&W
prev_frame = readFrame(input_video);
%prev_frame = rgb2gray(prev_frame);

% Probably should pad every frame of the video, but for now the macro block size is constant
while hasFrame(input_video)
    curr_frame = readFrame(input_video);
    %curr_frame = rgb2gray(curr_frame);

    motionVecY = zeros(ceil(inHeight/MB_SIZE), ceil(inWidth/MB_SIZE)); 
    motionVecX = motionVecY;

    [motionVecY, motionVecX, predictedResult] = threeStepSearch(prev_frame, curr_frame, inHeight, inWidth, MB_SIZE, motionVecY, motionVecX, max_motion_displacement); 
    
    figure(1); imshow(curr_frame);

    figure(2);
    plot_MV_function(input_video.Height, input_video.Width, MB_SIZE, motionVecY, motionVecX);

    figure(3); imshow(predictedResult);

    prev_frame = curr_frame; pause
end

function [mvH, mvW, predictedFrame] = threeStepSearch(reference, current, height, width, blockSize, mvH, mvW, blockDisplacement, predictedFrame)

    bsize1 = blockSize - 1;

    % Process by macroblock
    bH = 0; % block indices
    for i = 1:blockSize:height-bsize1
        bH = bH + 1; bW = 0;
        for j = 1:blockSize:width-bsize1
            bW = bW + 1;

            y_offset = mvH(bH, bW);
            x_offset = mvW(bH, bW);

            sad = calcSAD(current(i:(i+bsize1), j:(j+bsize1), :), reference((i+y_offset):(i+y_offset+bsize1), (j+x_offset):(j+x_offset+bsize1), :));

            minSad = sad;
            x_min = x_offset; y_min = y_offset;

            % mvH and mvW are assumed to initially store only zeros (meaning the centre value)

            stepSize = blockDisplacement;

            while stepSize >= 1 
                for dy = (-stepSize+y_min):stepSize:(stepSize+y_min)
                    for dx = (-stepSize+x_min):stepSize:(stepSize+x_min)

                        if ((i + dy >= 1) && (i + dy <= height - bsize1) && (j + dx >= 1) && (j + dx <= width - bsize1))
                            sad = calcSAD(current(i:(i+bsize1), j:(j+bsize1), :), reference((i + dy):(i+dy+bsize1), (j+dx):(j+dx+bsize1), :));

                            if(sad < minSad) % update block
                                minSad = sad;
                                x_min = dx;
                                y_min = dy;
                            end
                        end
                    end
                end

                stepSize = stepSize / 2;
            end

            mvW(bH, bW) = x_min;
            mvH(bH, bW) = y_min;

            predictedFrame(i:i+bsize1, j:j+bsize1, :) = reference(i+y_min:i+y_min+bsize1, j+x_min:j+x_min+bsize1, :);
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

        %out = (sadY * sadU * sadV)^1/3; % Do the geometric mean, that might mean something
        out = (sadY + sadU + sadV)*1/3;
    else
        out = sum(abs(input1, input2), "all");
    end
end
