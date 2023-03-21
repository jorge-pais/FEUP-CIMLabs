samples = 0:(1E5 - 1);
x = sin(0.22*samples);

N = 2:2:14;     % Number of quatization bits
M = 2.^(N-1);   % number of quatization levels (bipolar)

for i = 1:length(N)
    fprintf("Number of bits: %d\n", N(i));

    x_Q = floor(0.5+ x.*M(i)); 

    index = find(x_Q==M(i)); % É necessário retirar o ultimo nivel de quantização
    B = maxk(unique(x_Q),2);
    x_Q(index) = B(2);

    x_R = x_Q./M(i);
    
    error = x - x_R;

    Px = sum(x_R.^2)/length(x_R);
    Perror = sum(error.^2)/length(error);
    SNR(i) = 10*log10(Px/Perror);
    fprintf("SNR = %d dB\n", SNR(i));
    
    corr_matrix = corrcoef(x, error);
    CORR(i) = corr_matrix(1,2);

    E(i,:) = error;
end

figure(1)   % plot the SNR
fprintf("Model parameters: \n");
fprintf("%d \n", polyfit(N(1:(length(N)-1)), SNR(1:(length(N)-1)), 1));
plot(N, SNR);
title("SNR vs Number of bits");

figure(2);
plot(N, CORR);
title("Error/Original signal correlation")

figure(3);
[H X] = hist(x, 50); equalize = 50/(max(x) - min(x));
bar(X, H/sum(H)*equalize, 0.5);
ylabel('FDP'); xlabel('x[n] amplitude');

pause
for i = 1:length(N)
    figure(4);
    [H X] = hist(E(i,:), 50); equalize = 50/(max(E(i,:)) - min(E(i,:)));
    bar(X, H/sum(H)*equalize, 0.5);
    ylabel('FDP'); xlabel('error amplitude');
    pause
end