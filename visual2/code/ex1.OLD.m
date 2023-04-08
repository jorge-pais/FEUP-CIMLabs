clear; close all;

IMAGE_FILE = "../someImages/templo.jpg";

A = imread(IMAGE_FILE); % load the image as 3 rgb channels
figure(1); imshow(A); title('Original image')
[H, W] = size(A, 1:2);

% firstly display the different RGB color channels
% along with the corresponding histograms
showRGB(A);

A_hsv = convertShowHSV(A);

% Now let the user select two points from the image
questdlg("You now have to select two points to indicate: (1) the FOREGROUND and (2) the BACKGROUND");

figure(1); % select the initial picture
points = ginput(2); points = floor(points); 
pointFG = points(1, :); pointBG = points(2, :);

segmentedImage = kMeansImage(A_hsv(:,:,1), pointFG, pointBG, 3);

%{
 A_noBG = uint8(zeros(H, W, 3));
for i = 1:H
    for j = 1:W
        if segmentedImage(i,j) == 0 %BG
            A_noBG(i, j, :) = [249 152 171];
        else
            A_noBG(i, j, :) = A(i,j,:);
        end
    end
end 
%}


figure; imshow(segmentedImage);
% now we can convert the image to be just the foreground
figure; imshow(labeloverlay(A, segmentedImage));