Fs = 22050;

pauta = ["C4", "D4", "E4", "F4", "F4", "F4", "C4", "D4", "C4", "D4", ...
    "D4", "D4", "C4", "G4", "F4", "E4", "E4", "E4", "C4", "D4", "E4", "F4"];

samples = zeros(1);

for i = 1:length(pauta)
    note = decodeNote(pauta(i));
    samples = [samples geranota(note, 0.3, Fs)];
end
samples = [samples zeros(1, 0.5*Fs)]; % add silence to avoid clicks

sound(samples, Fs)