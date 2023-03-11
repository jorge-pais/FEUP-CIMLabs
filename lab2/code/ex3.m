Fs = 22050;

do = "C4"; re = "D4"; mi = "E4"; fa = "F4"; sol = "G4";
pauta = [do, re, mi, fa, fa, fa, do, re, do, re, ...
    re, re, do, sol, fa, mi, mi, mi, do, re, mi, fa];

samples = zeros(1);

for i = 1:length(pauta)
    note = decodeNote(pauta(i));
    samples = [samples geranota(note, 0.3, Fs)];
end
samples = [samples zeros(1, 0.5*Fs)]; % add silence to avoid clicks

sound(samples, Fs)
audiowrite("ex3.wav", samples, Fs);