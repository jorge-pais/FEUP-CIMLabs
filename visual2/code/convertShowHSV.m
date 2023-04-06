function imageHSV = convertShowHSV(imageRGB)
    imageHSV = rgb2hsv(imageRGB);
    
    figure;
    subplot(2,3,1); imshow(imageHSV(:,:,1)); title('Hue');
    subplot(2,3,2); imshow(imageHSV(:,:,2)); title('Saturation');
    subplot(2,3,3); imshow(imageHSV(:,:,3)); title('Value');
    subplot(2,3,4); imhist(imageHSV(:,:,1)); title('Hist H');
    subplot(2,3,5); imhist(imageHSV(:,:,2)); title('Hist S');
    subplot(2,3,6); imhist(imageHSV(:,:,3)); title('Hist V');
end