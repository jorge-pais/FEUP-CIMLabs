close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

N = 256; F = 0.5;

[A1, A2] = ampliaReduz(N, F, 3);

psd1 = 10*log10(abs(fftshift(fft2(A1))).^2);
psd2 = 10*log10(abs(fftshift(fft2(A2))).^2);

Z=imzoneplate(N);
psdOrig = 10*log10(abs(fftshift(fft2(Z))).^2);

figure(10); pwelch(A1)
figure(11); pwelch(A2)
figure(12); pwelch(Z)

figure(20); clf
mesh(psd2)