clear; close all;
%
% CIM - Image Thresholding principles using MATLAB
%   Global Thresholding
%

IMAGE_FILE = 'coins.png';

A = imread(IMAGE_FILE);
figure; imshow(A), title('Original Image');

% noise filtering before thresholding
A_filtered = wiener2(A, [5,5]); figure; imshow(A_filtered)
figure; imhist(A_filtered), title('Histogram'); drawnow
% Apply a global threshold to the grayscale image
T = 110; % value chosen by inspection of the histogram
A_thresh = im2bw(A, T/255);
figure; imshow(A_thresh); title('Threshold Image (heuristic)'); drawnow

T2 = graythresh(A_filtered); % Automatic gray threshold detection
A_thresh2 = im2bw(A_filtered, T2);
figure; imshow(A_thresh2); title('Threshold Image (graythresh)');