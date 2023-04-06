close all

i=imread('cavalos.jpg');

i=rgb2gray(i);
[lines,columns]=size(i);

figure(1)
subplot(3,1,1); imshow(i), title('original image');
subplot(3,1,2); imhist(i), title('image histogram');

disp('select the lower threshold by inspecting the histogram');
t=input('lower threshold?');
disp('select the upper threshold by inspecting the histogram');
T=input('upper threshold?');


bin=i;

for l=1:lines
    for c=1:columns
        if i(l,c)>t
            if i(l,c)>T
                bin(l,c)=255;
            else
                bin(l,c)=128;
            end
        else
            bin(l,c)=0;
        end
    end
end

subplot(3,1,3); imshow(bin), title('segmented image with 2 thresholds');