clear; close all;

IMAGE_FILE = "../someImages/templo.jpg";

A = imread(IMAGE_FILE); % load the image as 3 rgb channels
figure(1); imshow(A); title('Original image')
[H, W] = size(A, 1:2);

% firstly display the different RGB color channels
% along with the corresponding histograms
showRGB(A);
A_hsv = convertShowHSV(A);

imageSegmentsRGB = imsegkmeans(A, 2);
imageSegmentsHSV = imsegkmeans(im2single(A_hsv), 2);
imageSegmentsHue = imsegkmeans(im2single(A_hsv(:,:,1)), 2);

% now we can display the resulting segments
figure; imshow(labeloverlay(A, imageSegmentsRGB)); drawnow; title('Image segments from RGB'); 
figure; imshow(labeloverlay(A, imageSegmentsHSV)); title('Image segments from HSV');
figure; imshow(labeloverlay(A, imageSegmentsHue)); title('Image segments from Hue channel'); 