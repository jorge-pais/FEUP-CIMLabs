BPM = 254; T_quarter = 60/BPM;
Fs = 22050;

% Load the notes+length for both voices
sheet_blue;

samples1 = zeros(1, floor(T_quarter*time1(1) * Fs)); % Initial Rest
for i = 2:length(voice1)
    nota = decodeNote(voice1(i));
    samples1 = [samples1 geranota(nota, T_quarter*time1(i), Fs)];
end

samples2 = zeros(1, floor(T_quarter*time2(1) * Fs));
for i = 2:length(voice2)
    nota = decodeNote(voice2(i));
    samples2 = [samples2 geranota(nota, T_quarter*time2(i), Fs)];
end

levelVoice1 = 0.5;
levelVoice2 = 0.5;
% Mix both tracks (and compensate for inconsistent note lenght)
samples = levelVoice1*samples1 + levelVoice2*samples2(1:length(samples1));
% Zero-padding + amplitude normalization to [-1, 1];
samples = [samples zeros(1, 100)]/max(abs(samples)); 

sound(samples, Fs);
audiowrite("blue.wav", samples, Fs);
