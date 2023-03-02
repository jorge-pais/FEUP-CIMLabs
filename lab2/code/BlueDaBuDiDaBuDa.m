BPM = 254; T_quarter = 0.2;
Fs = 22050;

% All note duration relative to quarter note (seminima)

voice1 = ["-", "A3", "Bb3", "D3", "G3", "Bb3", "C4", "F3", "A3", "Bb3", ...
    "G3", "Bb3", "D4", "Eb4"];
time1 = [2, 2, 1, 1, 1, 1, 1, 1, 1, 2, ...
    1, 1, 1, 1, 1, 1, 1];

voice2 = ["-", "G2", "F2", "Eb2", "C2"];
time2 = [4, 4, 3, 2, 4, 3];

samples1 = zeros(1, floor(T_quarter*time1(1)*Fs));

for i = 2:length(voice1)
    samples1 = [samples1 geranota(decodeNote(voice1(i)), T_quarter*time1(i), Fs)];
end

samples2 = zeros(1, floor(T_quarter*time2(1)*Fs));
for i = 2:length(voice2)
    samples2 = [samples2 geranota(decodeNote(voice2(i)), T_quarter*time2(i), Fs)];
end

samples = samples1 +samples2;

sound(samples, Fs);