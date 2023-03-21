A = imread("lena512.bmp");
figure(1); imshow(A);

for f = 2:2:4
    fprintf("F = %d\n", f);
    x_down = downsample(A, f); x_down = downsample(x_down.', f).'; % ALSO transpose
    figure(2); imshow(x_down);
    
    x_up = upsample(A, f); x_up = upsample(x_up.', f).';
    figure(3); imshow(x_up, [0 255]);

    x_repeat = filter2(ones(f, f), x_up);
    figure(4); imshow(x_repeat, [0 255]);
    pause;
end