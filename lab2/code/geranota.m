% Play me !
% aaa = geranota(2^(0/12), 1, 22050);
% max(aaa)
% plot(1:length(aaa), aaa)
% sound([aaa], 22050);
function amostras = geranota(nota, duracao, Fs)
    T0 = 1.0/(440.0*nota); % nota = 1 -> LA4 ou A
    
    K = 5;
    A = 5000;
    
    t = 0:1/Fs:duracao;
    t = t(1:(length(t)-1)); % Retirar a ultima amostra

    x=0;
    for k=1:K
        x = x - ((2*A)/(pi*k))*sin((2*pi*k*t)/(T0));
    end
    
    T_sinusoide = 4*duracao/10; % Periodo da sinusoide de transicao

    t = 0:1/Fs:T_sinusoide/4;
    t = t(1:(length(t)-1));
    index = 1:length(t);
    
    sinusoidal = sin((2*pi/T_sinusoide)*t);
    x(index) = x(index).*sinusoidal;
    x(floor(Fs*duracao)-index+1) = x(floor(Fs*duracao)-index+1).*sinusoidal;
    
    t = 0:1/Fs:duracao;
    t = t(1:(length(t)-1));
    plot(t,x);

    amostras = x./A; % normalizar

%     % Periodo fundamental da nota
%     T0 = 1.0/(440.0*nota);
%     
%     A = 5000;
%     K = 5;
% 
%     % Sintese da onda
%     n = 0:(1/Fs):duracao;
%     x = zeros(size(n));
%     for k = 1:K 
%         x = x - 2*A/(pi*k)*sin((2*pi/T0)*k.*n);
%     end
%     
%     % Fade-in using first quarter of sine wave
%     n = 0:(1/Fs):(duracao/10-(1/Fs));
%     x(1:(Fs*duracao/10)) = x(1:(Fs*duracao/10)) .* sin(2*pi/(0.4*duracao).*n); 
%     
%     % Fade-out using first quarter of the cosine
%     n = 0:(1/Fs):(duracao/10);
%     x((9/10*Fs*duracao):(Fs*duracao)) = x((9/10*Fs*duracao):(Fs*duracao)) .* cos(2*pi/(0.4*duracao).*n);
% 
%     amostras = x./A; % Normalize amplitudes, maybe at the end
end