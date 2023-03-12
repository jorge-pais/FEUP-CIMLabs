[x,FS]=audioread('u2.wav');

%sound(x,FS);


% Primeira opcao
figure(1);
spectrogram(x,hanning(512),256,1024,FS,'yaxis');

% Frequencias das notas
%x=highpass(x,800,FS);
%pitch(x,FS, WindowLength=1024, OverlapLength=128, Range=[800,2500])

% Obtencao do valor das notas (essencialmente o mesmo)
% for i = 1:512:length(x)
%     pwelch(x(i:(i+512)),rectwin(512),256,512,FS)
%     pause;
% end


do = nthroot(2,12)^(-9);
reb = nthroot(2,12)^(-8);
re = nthroot(2,12)^(-7);
mib = nthroot(2,12)^(-6);
mi = nthroot(2,12)^(-5);
fa = nthroot(2,12)^(-4);
solb = nthroot(2,12)^(-3);
sol = nthroot(2,12)^(-2);
lab = nthroot(2,12)^(-1);
la = 1;
sib = nthroot(2,12)^(1);
si = nthroot(2,12)^(2);


% Codigo sem sobreposicao das notas
%pauta1 = [NaN si la NaN mi solb mi solb si la NaN mi solb mi solb si la NaN mi solb mi aolb si la NaN];
%duracao1 = [0.3 0.9 0.8 1.8 0.6 0.25 0.25 0.25 0.9 0.8 1.8 0.6 0.25 0.25 0.25 0.9 0.8 1.8 0.6 0.25 0.25 0.25 0.9 0.8 2];

% # FA
pauta1 = [NaN si NaN NaN mi NaN mi NaN  si NaN NaN mi NaN mi NaN  si NaN NaN mi NaN mi NaN  si NaN NaN];
pauta2 = [NaN NaN la NaN NaN solb NaN solb  NaN la NaN NaN solb NaN solb  NaN la NaN NaN solb NaN solb  NaN la NaN];
duracao1 = [0.3 1.7 0.8 1 0.8 0.05 0.40 0.10  1.7 0.8 1 0.8 0.05 0.40 0.10  1.7 0.8 1 0.8 0.05 0.40 0.10  1.7 0.8 2];
duracao2 = [0.3 0.9 1.6 1 0.6 0.40 0.1 0.4  0.75 1.6 1 0.6 0.40 0.1 0.4  0.75 1.6 1 0.6 0.40 0.1 0.4  0.75 1.6 2];

amostras1 = [];
amostras2 = [];
for i=1:length(pauta1)
    amostras1 = [amostras1 geranota(4*pauta1(i), duracao1(i), FS)];
    amostras2 = [amostras2 geranota(4*pauta2(i), duracao2(i), FS)];
end

amostras = amostras1 + amostras2;

x = amostras/5000;
x = x/8;

figure(2);
%sound(x,FS);
spectrogram(x,hanning(512),256,1024, FS,'yaxis');

audiowrite('batata.wav',x,FS);

function amostras = geranota(nota, duracao, Fs)
    if isnan(nota)
        t = 0:1/Fs:duracao;
        %disp(length(t));
        amostras = zeros(1,(length(t)-1));
        return
    end
    T0 = 1.0/(440.0*nota); % nota = 1 -> LA4 ou A
    
    K = 5;
    A = 5000;
    
    t = 0:1/Fs:duracao;
    t = t(1:(length(t)-1)); % Retirar a ultima amostra

    x=0;
    for k=1:K
        x = x - ((2*A)/(pi*k))*sin((2*pi*k*t)/(T0));
    end
    
    % Fade in e fade out
    T_sinusoide = 4*duracao/10; % Periodo da sinusoide de transicao

    t = 0:1/Fs:T_sinusoide/4;
    t = t(1:(length(t)-1));
    index = 1:length(t);
    
    sinusoidal = sin((2*pi/T_sinusoide)*t);
    x(index) = x(index).*sinusoidal;
    x(Fs*duracao-index+1) = x(Fs*duracao-index+1).*sinusoidal;
    
    %%%%%%%%%%% Exponencial fade out %%%%%%%%%%%
    t = 0:1/Fs:9*duracao/10;
    t = t(1:(length(t)-1));
    index = 1:length(t);

    exponential = exp(-3*t);
    exponential = exponential(length(t)-index+1);
    x(Fs*duracao-index+1) = x(Fs*duracao-index+1).*exponential;

    amostras = x;
end

