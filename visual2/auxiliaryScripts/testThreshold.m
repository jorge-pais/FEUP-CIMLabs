% this script presents the histogram of the grayscale version of the
% selected image and asks the user to indicate and initial value of the
% threshold. With the indicated value it segments the image in two classes. 
% It then performs a number of iterations to obtain new values
% of the threshold based on the mean values of each of the classes. It
% stops when the new threshold value differs from the previous one by 0.05

disp('select your image');
[filename, pathname] = uigetfile('*.*', 'open image file');
fullname=fullfile(pathname,filename);

i=imread(fullname);
[lines,columns,depth]=size(i);
if depth>1
    j=rgb2gray(i);
else j=i;
end

figure
imhist(j)
disp('select an initial threshold by inspecting the histogram');
t=input('threshold?');
oldt=2*t;
numIterations=0;

j=double(j);
    
while abs(t-oldt) > 0.05 
    
    n=1;
    m=1;

    for i=1:lines
        for k=1:columns
            if j(i,k)>=t
                c1(n)=j(i,k);
                n=n+1;
            else
                c2(m)=j(i,k);
                m=m+1;
            end
        end
    end
    oldt=t;
    t=0.5*(mean(c1)+mean(c2));
    numIterations=numIterations+1;
end

t, oldt, numIterations

for i=1:lines
        for k=1:columns
            if j(i,k)>=t
                j(i,k)=255;
                
            else
                j(i,k)=0;
               
            end
        end
end


figure
imshow(uint8(j))

