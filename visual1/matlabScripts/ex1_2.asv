close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = '../images/testRGB.bmp';

% 1.1.1
A = imread(IMAGE_FILE);
figure(1); imshow(A);
title('Original picture')

% 1.1.3
A_ycbcr = rgb2ycbcr(A);
figure(2); imshow(A_ycbcr);
title('YCbCr conversion')

% 1.1.4
figure(3); title('Seperate YCbCr Channels')
subplot(1,3,1); imshow(A_ycbcr(:,:,1)); title('Luma');
subplot(1,3,2); imshow(A_ycbcr(:,:,2)); title('Blue Difference');
subplot(1,3,3); imshow(A_ycbcr(:,:,3)); title('Red Difference');