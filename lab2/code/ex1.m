%
% Codificação de Informação Multimedia
% Trabalho 2 - Exercicio 1
%

Fs = 22050; % Sampling frequency
A = 5000; % Wave amplitude coefficient
wave_freq = 440; % Wave fundamental frequency
K = 5; % Number of fourier coefficients

n = 0:(1/Fs):1; % Synthesize only one second
x = zeros(size(n));

for k = 1:K
    x = x - 2*A/(pi*k)*sin(2*pi*k*wave_freq.*n);
end

x = x./A; % Normalize volume

figure(1); plot(n(1:(1.1*Fs/wave_freq)), x((1:(1.1*Fs/wave_freq))))

sound(x, Fs)