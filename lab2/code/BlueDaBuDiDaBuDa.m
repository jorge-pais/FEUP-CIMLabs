BPM = 254; T_quarter = 60/BPM;
Fs = 22050;

% All note duration relative to quarter note (seminima)

voice1 = ["-", "A4", ...
    "Bb4", "D4", "G4", "Bb4",...
    "C5", "F4", "A4", "Bb4", ...
    "G4", "Bb4", "D5",...
    "Eb5", "G4", "D5", "C5", ...
    "Bb4", "D4", "G4", "Bb4",...
    "C5", "F4", "A4", "Bb4", ...
    "G4", "Bb4", "D5",...
    "Eb5", "G4", "D5", "C5", ...
    "Bb4", "D4", "G4", "Bb4",...
    "C5", "F4", "A4", "Bb4", ...
    "G4", "Bb4", "D5",...
    "Eb5", "G4", "D5", "C5", ...
    ...
    "Bb4", "D4", "G4", "Bb4",...
    "A4", "C4", "F4", "G4", ...
    "C4", "F4", "G4",...
    "F4", "G4", "A4",...
    ...
    "Bb4", "D4", "G4", "Bb4",...
    "C5", "F4", "A4", "Bb4", ...
    "G4", "Bb4", "D5",...
    "Eb5", "G4", "D5", "C5"];
time1 = [2, 2, ...
    1, 1, 1, 1, ...
    1, 1, 1, 2, ...
    1, 1, 1, ...
    1, 1, 1, 1, ...
    1, 1, 1, 1, ...
    1, 1, 1, 2, ...
    1, 1, 1, ...
    1, 1, 1, 1, ...
    1, 1, 1, 1, ...
    1, 1, 1, 2, ...
    1, 1, 1, ...
    1, 1, 1, 1, ...
    1, 1, 1, 1,...
    1, 1, 1, 2,...
    1, 1, 2,...
    1, 1, 1,...
    ...
    1, 1, 1, 1, ...
    1, 1, 1, 2, ...
    1, 1, 1, ...
    1, 1, 1, 1];
voice2 = ["-", ...
    "G2", "F2", "Eb2", "C2",...
    "G2", "F2", "Eb2", "C2",...
    "G2", "F2", "Eb2", "C2",...
    "G2", "G3", "G2", "G3", "F2", "F3", "F2", "Eb3", "Eb2", "Eb3", "Eb2", "Eb3", "C2", "C3", "C2", "C3"];
time2 = [4+16, 4, 3, 5, 4,...
    4, 3, 5, 4,...
    4, 3, 5, 4,...
    1,1,1,1, 1,1,1, 1,1,1,1,1, 1,1,1,1];

samples1 = zeros(1, floor(T_quarter*time1(1) * Fs));

for i = 2:length(voice1)
    samples1 = [samples1 geranota(decodeNote(voice1(i)), T_quarter*time1(i), Fs)];
end

samples2 = zeros(1, floor(T_quarter*time2(1) * Fs));
for i = 2:length(voice2)
    samples2 = [samples2 geranota(decodeNote(voice2(i)), T_quarter*time2(i), Fs)];
end

samples = 0.5*samples1 + 0.5*samples2(1:length(samples1));

sound(samples, Fs);
audiowrite("teste.wav", samples, Fs);