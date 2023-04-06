% this script imports an image, let's the user to select a circular region
% in the image and then applies a sharpen filter to the select region
% it asks the user to indicate the strength of the sharpen filter

I = imread('pout.tif');
figure(1), imshow(I)
disp('draw the desired circle');

%let's draw a circle in the image and create a mask with the drawn circle
hax = drawcircle(gca);
mask = createMask(hax);

%let's create a function that will filter with the 'imsharpen' filter, 
% the region inside the circle
% it's function f which will pass the input image x to the imsharpen
% function
disp('indicate the strength of the sharpen filter (positive integer)');
strength=input('strength?');

f = @(x)imsharpen(x,'Amount',strength)

% now let's use the roifilt2 function to apply the function f to the region
% of image I defined in the mask
J = roifilt2(I,mask,f);
figure(2), imshow(J)