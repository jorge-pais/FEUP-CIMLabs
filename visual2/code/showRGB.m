function showRGB(A)
    [H, W] = size(A, 1:2); 
    R = A(:,:,1);
    G = A(:,:,2);
    B = A(:,:,3);

    figure;
    subplot(2,3,1); imshow(cat(3, R, zeros(H, W), zeros(H, W))); title('Red');
    subplot(2,3,2); imshow(cat(3, zeros(H, W), G, zeros(H, W))); title('Green');
    subplot(2,3,3); imshow(cat(3, zeros(H, W), zeros(H, W), B)); title('Blue');
    subplot(2,3,4); imhist(R); title('Hist Red');
    subplot(2,3,5); imhist(G); title('Hist Green');
    subplot(2,3,6); imhist(B); title('Hist Blue');
end