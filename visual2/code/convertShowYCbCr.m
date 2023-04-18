function imageYCbCr = convertShowYCbCr(imageRGB)
    imageYCbCr = rgb2ycbcr(imageRGB);
    
    figure;
    subplot(2,3,1); imshow(imageYCbCr(:,:,1)); title('Luma');
    subplot(2,3,2); imshow(imageYCbCr(:,:,2)); title('Blue Chroma');
    subplot(2,3,3); imshow(imageYCbCr(:,:,3)); title('Red Chroma');
    subplot(2,3,4); imhist(imageYCbCr(:,:,1)); title('Hist Y');
    subplot(2,3,5); imhist(imageYCbCr(:,:,2)); title('Hist Cb');
    subplot(2,3,6); imhist(imageYCbCr(:,:,3)); title('Hist Cr');
end