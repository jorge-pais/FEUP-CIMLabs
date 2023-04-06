clear; close all;

IMAGE_FILE = "../someImages/Fosforos.tif";

A = imread(IMAGE_FILE);
figure; imshow(A);

segmentedImage = splitmerge(A, 2, @eval);

figure; imshow(labeloverlay(A, segmentedImage))

function a = eval(region)
    threshold = 10;

    a = (mean(mean(region(:)))) > threshold;
end