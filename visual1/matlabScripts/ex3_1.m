%fspecial
%imfilter

close all; clear;

%1.1.1
img = imread("images\praia.bmp");

N = 3;
radius = 5;
sigma = 1;
alpha = 0.01;
len = 50;
theta = 0; %angulo de rotacao

% Segundo exercício
filter = fspecial('average', N);
result1 = imfilter(img,filter,'replicate');

filter = fspecial('disk', radius);          % Tipo de blur
result2 = imfilter(img,filter,'replicate');

% Segundo exercício
filter = fspecial('gaussian', N, sigma);
result3 = imfilter(img,filter,'replicate');

filter = fspecial('laplacian', alpha);
result4 = imfilter(img,filter,'replicate');

filter = fspecial('log', N, sigma);
result5 = imfilter(img,filter,'replicate');

filter = fspecial('motion',len,theta);
result6 = imfilter(img,filter,'replicate');

filter = fspecial('prewitt');
result7 = imfilter(img,filter,'replicate');

filter = fspecial('sobel');
result8 = imfilter(img,filter,'replicate');

filter = fspecial('unsharp');
result9 = imfilter(img,filter,'replicate');

figure(1);

imshow(result1);
title('average', 'FontSize', 15);

figure(2);
imshow(result2);
title('disk', 'FontSize', 15);

figure(3);
imshow(result3);
title('gaussian', 'FontSize', 15);

figure(4);
imshow(result4);
title('laplacian', 'FontSize', 15);

figure(5);
imshow(result5);
title('log', 'FontSize', 15);

% figure(6);
% imshow(result6);
% title('motion', 'FontSize', 15);

figure(7);
imshow(result7);
title('perwitt', 'FontSize', 15);

figure(8);
imshow(result8);
title('sobel', 'FontSize', 15);


figure(9);
imshow(img);







