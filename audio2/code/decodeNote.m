function factor = decodeNote(name)
    match = regexp(name, '([A-Za-z#]+)(\d+)', 'tokens');
    letters = match{1}{1};
    numbers = str2double(match{1}{2});
   
    oct = 2^(numbers-4); % get the octave

    switch letters
        case "C"
            factor = oct * 2^(-9/12);
        case {"C#", "Db"}
            factor = oct * 2^(-8/12);
        case "D"
            factor = oct * 2^(-7/12);
        case {"D#", "Eb"}
            factor = oct * 2^(-6/12);
        case "E"
            factor = oct * 2^(-5/12);
        case "F"
            factor = oct * 2^(-4/12);
        case {"F#", "Gb"}
            factor = oct * 2^(-3/12);
        case "G"
            factor = oct * 2^(-2/12);
        case {"G#", "Ab"}
            factor = oct * 2^(-1/12);
        case "A"
            factor = oct;
        case {"A#", "Bb"}
            factor = oct * 2^(1/12);
        case "B"
            factor = oct * 2^(2/12);
    end
end