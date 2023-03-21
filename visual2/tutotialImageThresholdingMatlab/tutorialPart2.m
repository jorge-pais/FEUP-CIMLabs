clear; close all;
%
% CIM - Image Thresholding principles using MATLAB
%   Adaptative Thresholding
%

IMAGE_FILE = 'gradient_with_text.png';

% the image is already b&w, but matlab is importing it as RGB
A = rgb2gray(imread(IMAGE_FILE));
figure; imshow(A); title('Original Image'); drawnow

A_gthresh = im2bw(A, graythresh(A));
figure; imshow(A_gthresh); title('Global Thresholding');
figure; imhist(A), title('Histogram of Original');

A_thresh = blkproc(A, [10 10], @adapt_thresh);
figure; 
subplot(1,2,1); imshow(A); title('Original Image');
subplot(1,2,2); imshow(A_thresh); title('Adaptive Thresholding');

std_without_text = std2(A(1:10, 1:10))
std_with_text = std2(A(200:210, 200:210))