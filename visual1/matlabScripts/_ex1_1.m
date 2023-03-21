close all; clear all;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = '../images/testRGB.bmp';

% 1.1.1
A = imread(IMAGE_FILE);
figure(1); imshow(A);
title('Original picture');

% 1.1.2
figure(2); title('Seperate Colour Channels')
length = size(A); length = length(1:2);
% These first lines display each of the colour channels as gray scale
subplot(2,3,1); imshow(A(:,:,1)); title('Red');
subplot(2,3,2); imshow(A(:,:,2)); title('Green');
subplot(2,3,3); imshow(A(:,:,3)); title('Blue');
% These second lines are to isolate each colour channel
subplot(2,3,4); imshow(cat(3, A(:,:,1), zeros(length), zeros(length)));
subplot(2,3,5); imshow(cat(3, zeros(length), A(:,:,2), zeros(length)));
subplot(2,3,6); imshow(cat(3, zeros(length), zeros(length), A(:,:,1)));

% 1.1.3
A_hsv = rgb2hsv(A);
figure(3); title('HSV conversion');
imshow(A_hsv);

% 1.1.4
figure(4); title('Seperate HSV Channels')
subplot(1,3,1); imshow(A_hsv(:,:,1)); title('Hue');
subplot(1,3,2); imshow(A_hsv(:,:,2)); title('Saturation');
subplot(1,3,3); imshow(A_hsv(:,:,3)); title('Value');