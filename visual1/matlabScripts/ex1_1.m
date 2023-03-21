close all; clear;

%1.1.1
img = imread("lighthouse.png");

%1.1.2
imgR=img(:,:,1);
imgG=img(:,:,2);
imgB=img(:,:,3);

figure(1);
imshow(img);
fontSize = 10;
title('Original RGB Image', 'FontSize', fontSize);

dim = size(img); dim = dim(1:2);

figure(2);
subplot(2,3,1);
imshow(imgR);
title('Red Channel', 'FontSize', fontSize);

subplot(2,3,2);
imshow(imgG);
title('Green Channel', 'FontSize', fontSize);

subplot(2,3,3);
imshow(imgB);
title('Blue Channel', 'FontSize', fontSize);


subplot(2,3,4);
imshow(cat(3, imgR, zeros(dim), zeros(dim)));
title('Colored Red Channel', 'FontSize', fontSize);

subplot(2,3,5);
imshow(cat(3, zeros(dim), imgG, zeros(dim)));
title('Colored Green Channel', 'FontSize', fontSize);

subplot(2,3,6);
imshow(cat(3, zeros(dim), zeros(dim), imgB));
title('Colored Blue Channel', 'FontSize', fontSize);

%1.1.3
imgHSV = rgb2hsv(img);

figure(3);
imshow(imgHSV);
title('Original HSV Image', 'FontSize', fontSize);

imgH=imgHSV(:,:,1);
imgS=imgHSV(:,:,2);
imgV=imgHSV(:,:,3);

figure(4);
%subplot(1,3,1);
imshow(imgH);
title('Hue Channel', 'FontSize', fontSize);

figure(5);
%subplot(1,3,2);
imshow(imgS);
title('Saturation Channel', 'FontSize', fontSize);

figure(6);
%subplot(1,3,3);
imshow(imgV);
title('Value/Intensity Channel', 'FontSize', fontSize);



