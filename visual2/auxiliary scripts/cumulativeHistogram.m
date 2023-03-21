% this script uses the cumulative histogram technique to obtain the value
% of threshold to be used in a segmentation by clustering approach
% by looking at the image, the user should provide an estimate of the % of
% pixels occupied in the image by the foreground objects and it should
% indicate whether the background is lighter 'L' or darker 'D' than the foreground
% objects. After having obtained the threshold, the image is segmented in
% two classes (background and foregound) generating a B&W image

disp('select your image');
[filename, pathname] = uigetfile('*.*', 'open image file');
fullname=fullfile(pathname,filename);

i=imread(fullname);
[lines,columns,depth]=size(i);
if depth>1
    j=rgb2gray(i);
else j=i;
end

disp('indicate a tentative % of pixels for the foreground (objects) - a value from 0 to 100');
p=input('% of pixels in foreground?');

disp('is the background darker or lighter than the foreground? - D or L');
b=input('D or L?');
if b=='D'
    p=p/100;
else
    p=1-p/100;
end

figure, imhist(j)
histogram=imhist(j);
sum=0;
a=1;
while sum<(lines*columns)*p && a< 256
    sum=sum+histogram(a);
    a=a+1;
end

T=a-1


for i=1:lines
        for k=1:columns
            if j(i,k)>=T
                j(i,k)=255;
                
            else
                j(i,k)=0;
               
            end
        end
end

figure, imshow(uint8(j));