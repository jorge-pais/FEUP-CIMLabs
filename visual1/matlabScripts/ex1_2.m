close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = 'lighthouse.png';

% 1.1.1
A = imread(IMAGE_FILE);
figure(1); imshow(A);
title('Original picture')

figure(2); title('Seperate Colour Channels')
length = size(A); length = length(1:2);
subplot(1,3,1); imshow(cat(3, A(:,:,1), zeros(length), zeros(length)));
subplot(1,3,2); imshow(cat(3, zeros(length), A(:,:,2), zeros(length)));
subplot(1,3,3); imshow(cat(3, zeros(length), zeros(length), A(:,:,1)));

A_ycbcr = rgb2ycbcr(A);
figure(3); imshow(A_ycbcr);
title('YCbCr conversion')

figure(4); title('Seperate YCbCr Channels')
subplot(1,3,1); imshow(A_ycbcr(:,:,1)); title('Luma');
subplot(1,3,2); imshow(A_ycbcr(:,:,2)); title('Blue Difference');
subplot(1,3,3); imshow(A_ycbcr(:,:,3)); title('Red Difference');