clear; close all;
%
% CIM - Trabalho Visual 2
% Image Segmentation
%
% This code allows the user to easily select any image and perform a
% segmentation operation to it.
%

% image file selection prompt
fprintf("Welcome to the Image Segmenter MATLAB © script\nPlease indicate the desired image file in the file explorer prompt\n");

[filename, path] = uigetfile({'*.bmp;*.jpg;*.jpeg;*.jpe;*.jp2;*.tiff;*.tif;*.png;*.gif','All Image Files';...
        '*.bmp','Bitmap Files (*.bmp)';...
        '*.jpg;*.jpeg;*.jpe;*.jp2','JPEG Files (*.jpg;*.jpeg;*.jpe;*.jp2)';...
        '*.tiff;*.tif','TIFF Files (*.tiff;*.tif)';...
        '*.png','PNG Files (*.png)';...
        '*.gif','GIF Files (*.gif)'}, 'Select an image file');

IMAGE_FILE = [path, filename]; % concatenate (why isn't this the default)

I = imread(IMAGE_FILE);
figure; imshow(I); title('Original Image');

method = selectPrompt('Please indicate what segmentation method is to be used:\n[1] Clustering (K-means)\n[2] Region Split & Merge\n', [1, 2]);

switch method
case 1 % do clustering
    I_cluster = I;

    % Check whether the image has colour and allow the user to choose the appropriate colour channel
    if size(I, 3) == 3 
        showRGB(I);
        I_hsv = convertShowHSV(I);

        channel = selectPrompt('\nChoose the colour channel that best contrasts the desired image segments:\n[1] RGB - All Channels\n[11] RGB - Red Channel\n[12] RGB - Green Channel\n[13] RGB - Blue Channel\n[2] HSV - All Channels\n[21] HSV - Hue Channel\n[22] HSV - Saturation Channel\n[23] HSV - Value Channel\n', [1, 11, 12 ,13, 2, 21, 22, 23]);
        switch channel
            %case 1; I_cluster = I;
            case 11; I_cluster = I(:,:,1);
            case 12; I_cluster = I(:,:,2);
            case 13; I_cluster = I(:,:,3);
            case 2; I_cluster = im2single(I_hsv);
            case 21; I_cluster = im2single(I_hsv(:,:,1));
            case 22; I_cluster = im2single(I_hsv(:,:,2));
            case 23; I_cluster = im2single(I_hsv(:,:,3));
        end
    end

    clusters = uint8(input("Number of clusters/segments: "));
    % now we can do the clustering
    segments = imsegkmeans(I_cluster, clusters);

    figure; imshow(labeloverlay(I, segments)); drawnow; title('Image segments');

case 2 % do split and merge
    fprintf("This functionality is not yet implemented");

end


% Aux function for all the command line selection prompts
function x = selectPrompt(prompt, options)
    while true
        fprintf(prompt);
    
        x = uint8(input('Selection: '));
        if ismember(x, options)
            break;
        end
    end
end