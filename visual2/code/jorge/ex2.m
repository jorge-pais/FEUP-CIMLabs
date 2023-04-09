clear; close all;

IMAGE_FILE = "../someImages/Fosforos.tif";

A = imread(IMAGE_FILE);
figure; imshow(A); 

segmentedImage = splitmerge(A, 2, @predicate);

disp("Segments found: ");
disp(length(unique(segmentedImage)))

figure; imshow(labeloverlay(A, segmentedImage))

function a = predicate(region)
    sd = std2(region);
    m = mean2(region);

    a = (sd > 10) & ((m > 80/255) | (m < 40/255));
end