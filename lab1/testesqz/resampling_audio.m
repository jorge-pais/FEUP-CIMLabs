% Audio part
[x, Fs] = audioread("sting22.wav");

%sound(x, Fs); pause

for f = 2:2:4
    fprintf("F = %d\n", f);
    x_down  = downsample(x, f); % Decimate signal, downsample
    x_up    = upsample(x, f);   % Upsample the signal, this can be used also in conjunction with the filter to get
    x_repeat= filter(ones(1,f), 1, x_up); % all ones impulse response, since the x_up samples are spaced out by zeros
    
    % Now the can listen to the signals (note the playback frequency!!!)
    fprintf("Playing the downsampled signal now!\n"); sound(x_down, Fs/f); pause; clear sound;
    fprintf("Playing the upsampled signal now!\n"); sound(x_up, Fs*f); pause; clear sound;
    sound(x, Fs); pause; clear sound;
    fprintf("Playing the repeated samples signal now!\n"); sound(x_repeat, Fs*f); pause; clear sound;
end

% From this, it is possible to gather that the downsampling operation
% performed to the signal is equivalent to having sampled the original song
% at a lower sampling rate (when played at the correct speed Fs/f).

% If the signal is played with at the original sampling frequency Fs, the
% audio doesnt's appear to have lost that much quality from being sped up.