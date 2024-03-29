%Main program for performing EBMA between two images
%Compute Motion Vectors between Anchor Frame and Target Frame 
%Calling functions EBMA_integer.m or EBMA_half.m  and plot_MV_function.m
%Yao Wang, Xiaofeng Xu,  Polytechnic University, 10/8/2003

clear all;
close all;

INPUT_FILE = '../videoSequences/wg_cs_1.mpg';

videoFile = VideoReader(INPUT_FILE);

dx = videoFile.width ;dy=videoFile.height;

frame1 = read(videoFile, 2);
frame2 = read(videoFile, 3);

img1 = cat(3, frame1(:,:,1)', frame1(:,:,2)', frame1(:,:,3)'); 
img2 = cat(3, frame2(:,:,1)', frame2(:,:,2)', frame2(:,:,3)');

figure(1);
image(img1), colormap(gray(256)); axis image;
title('Target Image');

figure(2);
image(img2), colormap(gray(256)); axis image;
title('Anchor Image');

bsize=16; vsrange=16; hsrange=16;
pimg=img1;
%initialize predicted image to img1.
bdy=ceil(dy/bsize); bdx=ceil(dx/bsize);
mvy=zeros(bdy,bdx); mvx=zeros(bdy,bdx);
%mvy and mvx save the block-wise vertical and horizontal motions (i.e. the motion field)
%initialize the motion field to zeros

t0 = clock;

%for integer pel EBMA:
[mvy,mvx,pimg] = EBMA_integer(img1, img2, dy, dx, bsize, vsrange, hsrange, mvy, mvx, pimg);

%for half-pel BEMA
%[mvy,mvx,pimg] = EBMA_half(img1, img2, dy, dx, bsize, vsrange, hsrange, mvy, mvx, pimg);
runtime=etime(clock,t0);
fprintf('Total running time (second):%6.2f \n',runtime);


figure(3);
image(pimg), colormap(gray(256)); axis image; axis off;
title('Predicted Image');

figure(4);
imagesc(abs(img2-pimg)), colormap(gray(256)); axis image;
title('Prediction Error Image');

figure(5);
plot_MV_function(dy,dx,bsize,mvy,mvx);set(gca,'XTick',[],'YTick',[]);
title('Motion Field');

mse=sum(sum((img2-pimg).*(img2-pimg)))/dx/dy;
psnr=10*log10(255*255/mse);
fprintf('PSNR of predicted image (dB):%6.2f\n',psnr);


