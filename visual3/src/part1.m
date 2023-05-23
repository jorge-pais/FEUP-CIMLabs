%
%   CIM Visual Assignment 3 - Video Shot Detection
%
%   Part 1 - Temporal Segmentation via Image Characteristic Extraction
%       
%   This is a testbench to validate and exemplify the video segmenter function.
%   
%
clear; close all;
INPUT_FILE = "../videoSequences/wg_cs_1.mpg";
OUTPUT_FILE = "../results/output";
TIME_PER_FRAME = 0.5; 

input_video = VideoReader(INPUT_FILE);

%frames = part1segmenter(INPUT_FILE, 'spacialActivity', 0.0142);
%cutFrames = part1segmenter(input_video, 'contourRateOfChange', 0);

%pause

cutFrames = part1segmenter(input_video, 'colourHistogram', 2031, true);

% Save the video file and generate a
output = VideoWriter(OUTPUT_FILE, 'Archival'); % Motion JPEG 2000 (mpg)
open(output)

frames = []; 
for i = 1:length(cutFrames)
    frame = read(input_video, cutFrames(i));
    for j = 1:floor(TIME_PER_FRAME*30);
        frames = cat(4, frames, frame);
    end
end

writeVideo(output, frames);
close(output)