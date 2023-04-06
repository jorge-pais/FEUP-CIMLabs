i=imread('contornos.png');
figure (1); imshow(i), title('Original image');
se = strel('square',3);
dilatedImage = imdilate(i, se); 
%figure (2); imshow(dilatedImage);
shrinkedImage = imerode(i, se); 
%figure (3); imshow(shrinkedImage);
contour=dilatedImage-shrinkedImage;
%figure(4); imshow(dilatedImage-shrinkedImage);
recoveredImage=imerode(dilatedImage,se); 
%figure (5); imshow(recoveredImage);
differenceImage=i-recoveredImage;

imO = insertInImage(i, @()text(10,10,'Original'),{'color',[1 1 1],'fontsize',9});
imD = insertInImage(dilatedImage, @()text(10,10,'Dilated'),{'color',[1 1 1],'fontsize',9});
imS = insertInImage(shrinkedImage, @()text(10,10,'Shrinked'),{'color',[1 1 1],'fontsize',9});
imContour=insertInImage(contour, @()text(10,10,'Contour'),{'color',[1 1 1],'fontsize',9});
imR = insertInImage(recoveredImage, @()text(10,10,'Recovered'),{'color',[1 1 1],'fontsize',9});
imDif = insertInImage(differenceImage, @()text(10,10,'Difference'),{'color',[1 1 1],'fontsize',9});

figure(2); 
montage({imO,imD,imS,imContour,imR,imDif});
title("Montage of processed images")

%plot_labels = {'original', 'dilated', 'shrinked', 'contours' ...
%    'recovered', 'difference'};