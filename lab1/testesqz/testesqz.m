
% M.EEC045 - CODIFICACAO DE INFORMACAO MULTIMEDIA
%
% first home assignment (audio part)
%
% due date: February 24, 2023
%
% Anibal Ferreira

% AUDIO PART

[x,FS]=audioread('sting22.wav');
% [x,FS,NBITS]=wavread('sting22.wav'); % old Matlab versions
NBITS=16;
%sound(x,FS,NBITS); % NOTA: x values are already in the range [-1, 1]
sound(x(1:1*FS), FS, NBITS); % Only play the song for 2 seconds
samples=[0:length(x)-1];
figure(1)
plot(samples/FS, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('sting22.wav');

N = 2:2:NBITS;  % Values for requantization
M = 2.^(N-1);   % Number of quantization levels (bipolar)

for i = 1:length(N) % Requantize
    fprintf("Number of bits: %d \n", N(i));
    x_Q = floor(0.5+x.*M(i)); % Round-up approximation
    x_R = x_Q./M(i);
    
    error = x_R-x;
    Px = sum(x_R.^2)/length(x_R);
    Perror = sum(error.^2)/length(error);
    SNR(i) = 10*log10(Px/Perror);
    fprintf("SNR = %d dB\n", SNR(i));
    
    sound(x_R, FS, NBITS); % listen to each result!
    pause
    %sound(error, FS, NBITS);
    %pause
end

figure(2)   % plot the SNR
fprintf("Model parameters: \n");
fprintf("%d\n", polyfit(N(1:(length(N)-1)), SNR(1:(length(N)-1)), 1));
plot(N, SNR);
title("Audio SNR");
xlabel("Number of quantization bits - N");
ylabel("Signal-to-Noise Ratio - SNR");
pause
% IMAGE PART

% reads and displays image
A=imread('lena512.bmp');
figure(2)
imshow(A,[0 255]); % displays original image
A=single(A)/255.0; % convert to float and normalizes [0, 1.0]
title('lena512.bmp');

% insert code here
Ar=A; % this is temporary, to be replaced by the new code

N = 2:2:NBITS;  % Values for requantization
M = 2.^N;   % Number of quantization levels (unipolar)

for i = 1:length(N)
    fprintf("Number of bits: %d \n", N(i));
    A_Q = floor(0.5+A.*M(i));
    A_R = A_Q./M(i);

    error = A_R - A;
    Px = sum(A_R.^2)/length(error);
    Perror = sum(error.^2)/length(error);
    SNR(i) = 10*log10(Px/Perror);
    fprintf("SNR = %d dB\n", SNR(i));

    Ar=uint8(A_R*255.0); % convert to "uint" format
    figure(3)
    imshow(Ar,[0 255]); % displays modified image
    title('modified Lena, N');

    pause
end

figure(4)   % plot the SNR
fprintf("Model parameters: \n");
fprintf("%d", polyfit(N(1:(length(N)-1)), SNR(1:(length(N)-1)), 1));
plot(N, SNR);
title("Image SNR");
xlabel("Number of quantization bits - N");
ylabel("Signal-to-Noise Ratio - SNR");