close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = 'cameraman.tif';

A = imread(IMAGE_FILE);
figure(1)
imshow(A); title('Original'); drawnow; pause

THRESHOLD = [0.3 0.7]; SIGMA = 1;

A_canny = edge(A, "canny", THRESHOLD, SIGMA);
figure(2)
imshow(uint8(255*A_canny)); title("Canny edge detection")