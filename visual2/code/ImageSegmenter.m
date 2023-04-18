clear; close all;
%
% CIM - Trabalho Visual 2
% Image Segmentation
%
% This code allows the user to easily select any image and perform a
% segmentation operation to it.
%

% image file selection prompt
fprintf("Welcome to the Image Segmenter MATLAB script\nPlease indicate the desired image file in the file explorer prompt\n");

[filename, path] = uigetfile({'*.bmp;*.jpg;*.jpeg;*.jpe;*.jp2;*.tiff;*.tif;*.png;*.gif','All Image Files';...
        '*.bmp','Bitmap Files (*.bmp)';...
        '*.jpg;*.jpeg;*.jpe;*.jp2','JPEG Files (*.jpg;*.jpeg;*.jpe;*.jp2)';...
        '*.tiff;*.tif','TIFF Files (*.tiff;*.tif)';...
        '*.png','PNG Files (*.png)';...
        '*.gif','GIF Files (*.gif)'}, 'Select an image file');

IMAGE_FILE = [path, filename] % concatenate (why isn't this the default)

I = imread(IMAGE_FILE);
figure; imshow(I); title('Original Image');

method = selectPrompt('\nPlease indicate what segmentation method is to be used:\n[1] Clustering (K-means)\n[2] Region Split & Merge\n', [1, 2]);

% (Optional) Apply preprocessing to the input image
I_orig = I;
%I = preprocessing(I);

switch method
case 1 % do clustering
    I_cluster = I;

    % Check whether the image has colour and allow the user to choose the appropriate colour channel
    if size(I, 3) == 3 
        showRGB(I);
        I_hsv = convertShowHSV(I);
        I_ycbcr = convertShowYCbCr(I);

        channel = selectPrompt('\nChoose the colour channel that best contrasts the desired image segments:\n[1] RGB - All Channels\n[11] RGB - Red \n[12] RGB - Green \n[13] RGB - Blue \n[2] HSV - All Channels\n[21] HSV - Hue \n[22] HSV - Saturation \n[23] HSV - Value \n[3] YCbCr - All Channels\n[31] YCbCr - Y/Luma \n[32] YCbCr - Blue Chroma \n[33] YCbCr - Red Chroma \n', [1, 11, 12 ,13, 2, 21, 22, 23, 3, 31, 32, 33]);
        switch channel
            %case 1; I_cluster = I;
            case 11; I_cluster = I(:,:,1); % R
            case 12; I_cluster = I(:,:,2); % G
            case 13; I_cluster = I(:,:,3); % B
            case 2;  I_cluster = im2single(I_hsv);
            case 21; I_cluster = im2single(I_hsv(:,:,1)); % H
            case 22; I_cluster = im2single(I_hsv(:,:,2)); % S
            case 23; I_cluster = im2single(I_hsv(:,:,3)); % V
            case 3;  I_cluster = I_ycbcr;
            case 31; I_cluster = I_ycbcr(:,:,1);
            case 32; I_cluster = I_ycbcr(:,:,2);
            case 33; I_cluster = I_ycbcr(:,:,3);
        end
    end

    clusters = uint8(input("\nNumber of clusters/segments: "));
    % now we can do the clustering
    segments = imsegkmeans(I_cluster, clusters);

    %figure; imshow(labeloverlay(I, segments)); drawnow; title('Image segments');

case 2 % do split and merge    
    dim = uint8(input("\nWhat is the minimum division to apply the algorithm to? - "));

    I_split = I;
    if size(I, 3) == 3; I_split = rgb2gray(I); end
        
    segments = splitmerge(I_split, dim, @predicate);
    %segments = splitmerge(I, dim, @predicate);

    fprintf("\nThe number of distinct regions detected was %d\n", length(unique(segments)));
end

figure; imshow(labeloverlay(I_orig, segments)); drawnow; title('Image segments');


% ===================== AUXILIARY FUNCTIONS =====================

function x = selectPrompt(prompt, options)
    while true
        fprintf(prompt);
    
        x = uint8(input('Selection: '));
        if ismember(x, options) % there are no do-while loops in matlab unfortunatly
            break;
        end
    end
end

% Predicte function taken from:
%   Digital Image Processing using MATLAB - Gonzalez, Woods
function a = predicate(region) 
    sd = std2(region);
    m = mean2(region);
    
    a = (sd > 10) & ((m > 80/255) | (m < 40/255));
end