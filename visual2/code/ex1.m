clear; close all;

IMAGE_FILE = "../someImages/LimaoPiao.JPG";

A = imread(IMAGE_FILE); % load the image as 3 rgb channels
figure; imshow(A); title('Original image')

% firstly display the different RGB color channels
% along with the corresponding histograms
showRGB(A);

A_hsv = convertShowHSV(A);

%pause

% Then we can perform the K-mean algorithm to figure out the background and
% the foreground
[H, W] = size(A, 1:2);

% the following points were determined randomly to ensure that the initial
% BG and FG means are chosen correctly
pointFG = [1106 1494]; %[Y, X]
pointBG = [514 2702];

segmentedImage = kMeansImage(A_hsv(:,:,1), pointFG, pointBG, 3);
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

figure; imshow(segmentedImage);
% now we can convert the image to be just the foreground
figure; imshow(A_noBG);