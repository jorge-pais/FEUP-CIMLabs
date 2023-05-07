clear; close all;

%
% Este conjunto de comandos Matlab faz parte das aulas
% da UC CODIFICA��O DE INFORMA��O MULTIM�DIA
% (CIM), integrada no Mestrado  em
% Engenharia Electrot�cnica e Computadores (M.EEC), da
% Faculdade de Engenharia da Universidade do Porto (FEUP).
%
% � permitida a utiliza��o por outras pessoas que n�o
% frequentem a disciplina, unicamente para objectivos acad�micos
% ou auto-estudo e desde que seja feita men��o, em qualquer trabalho
% publicado ou exposto publicamente, da fonte: "Elementos de Estudo
% da Unidade Curricular CIM do curso M.EEC (FEUP)".
%
% Qualquer outra utiliza��o dever� ser objecto de um pedido
% de autoriza��o dirigido por escrito ao autor e que s�
% ser� v�lido se houver uma resposta EXPL�CITA e favor�vel.
%
% (c) An�bal Ferreira; ajf(at)fe.up.pt
%

% objectivo: análise, modificação no domínio das frequências e síntese de
% um sinal áudio


% input audio file (raw PCM)
%
inpfile = '../audio/sound.wav';
outfile = '../audio/newsound_coloured_5dB.wav';

%
% N        = comprimento da transformada DFT (calculada atrav'es da FFT)
% N/2      = sobreposição entre tramas, i.e, overlap é de 50%
% win      = janela de análise (qual a sua utilidade ?)
%
% Ans: esta janela de análise para minimizar as amplitudes dos pontos nas extremidades temporais dos segmentos, e portanto minizar a diferença que a análise possa ter entre os diferentes segmentos
N = 1024; N2 = N/2;
win = sin(pi/N*(0:(N-1)).');

%
% lê ficheiro áudio
%
[datain, FS] = audioread(inpfile); % NOTA: dados surgem normalizados entre 0 e 1
nread = length(datain);
disp('Frequência de amostragem: '); FS

% vector de sa�da
dataout = zeros(size(datain));
tmpdata = zeros(N,1);	%% input (int) data

% NOTA: usamos para visualizar só os pontos
% entre 1 e N/2+1 da análise de Fourier (calculada
% através da FFT) já que os restantes são uma
% repeticão destes, porquê ?
%
% Ans: o sinal que estamos a utilizar é real, e portanto na sua representação no dominio de fourier o seu espectro repete-se
regiaofreq = 1:N2+1;

frame = 1;

% relaçao signal-to-mask desejada para a quantizaçao
SMR = 1; % dB

% este ciclo faz o varrimento e o processamento do sinal por segmentos
while((frame+1)*N2 < nread)

% NOTA: a instrução seguinte é usada para
% delimitar o segmento que se pretende seleccionar
   varre = [1+(frame-1)*N2:(frame+1)*N2];

   tmpdata = datain(varre);

% representa sinal temporal
   figure(1);
   plot([0:N-1], tmpdata(1:N));
   xlabel('Amostras temporais');
   ylabel('Amplitude normalizada');
   title('Sinal nos Tempos');
   
%
% FFT
%
   tmpdata = tmpdata.*win;
   fdata = fft(tmpdata);
   magnitude = eps+abs(fdata);
   fase = angle(fdata);

   figure(2);
   plot(FS/N*(regiaofreq-1),20*log10(magnitude(regiaofreq)));
   xlabel('Frequência');
   ylabel('Densidade Espectral (dB)');
   title('Sinal nas Frequências');
   
%   aqui tem lugar a modificação espectral

%   ruído de quantização fica com espectro plano
%   ...
   %Ps = sum(abs(fdata).^2); % Potência do espetro do segmento
   %quantum = sqrt(12*Ps/(N*10^(SMR/10))); % Passo de quantização
   %X_Q = floor(0.5+0.5*j + fdata./quantum);  % Sinal quantização DFT

%  ruído de quantização fica com espectro semelhante ao do sinal (SMR constante)
%  ...
   Ps = abs(fdata).^2;
   quantum = sqrt(12.*Ps./(10^(SMR/10)));
   X_Q = floor(0.5 + 0.5*j + fdata./quantum);
%
% IFFT
   %fdata=magnitude.*exp(i*fase);
   
   fdata = quantum.*X_Q;

   figure(2);
   hold on;
   plot(FS/N*(regiaofreq-1), 20*log10(abs(fdata(regiaofreq))) ,'r');
   hold off;

%    fdata(1)=magnitude(1)*sign(exp(i*fase(1))); % porquê ?
%    fdata(N2+1)=magnitude(N2+1)*sign(exp(i*fase(N2+1))); % porquê ?
   fdata(N:-1:N2+2)=conj(fdata(2:N2)); % porquê ?
   
   tmpdata = real(ifft(fdata));
   tmpdata = tmpdata.*win;
   dataout(varre) = dataout(varre)+tmpdata;
   
   figure(1);
   hold on;
   plot([0:N-1],tmpdata(1:N),'r');
   hold off;

   pause;
   frame=frame+1;

end

% grava sinal de sa�da
audiowrite(outfile, dataout, FS);
% wavwrite(dataout, FS, bits, outfile); % OLD

% calculo do SNR: de modo identico ao utilizado em qzmdct.m

error = dataout - datain;
Psignal = sum(datain.^2);
Pnoise = sum(error.^2);
SNR = 10*log10(Psignal/Pnoise);

disp('Final SNR: '); SNR

disp('Fim de processamento.');