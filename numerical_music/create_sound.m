function [signal fs] = create_sound(filename)
  file = fopen(filename, 'r');
  data = fgetl(file);
  data = strtrim(strsplit(data, ','));
  bpm = str2num(data{1});
  fs = str2num(data{2});
  num_instruments = str2num(data{3});

  instrument_map = create_instruments(file, fs, num_instruments);

  % This is the format of the sound:
  % kick, _,hihat, _,kick, _,hihat, _
  % _ means that there is no sound but allows bleeding from previous sound

  pat1 = parse_pattern(file, fs, bpm, instrument_map);
  pat2 = parse_pattern(file, fs, bpm, instrument_map);

  fclose(file);

  if length(pat1) > length(pat2)
    pat2 = [pat2 zeros(1, length(pat1) - length(pat2))];
  else
    pat1 = [pat1 zeros(1, length(pat2) - length(pat1))];
  end

  signal = pat1 + pat2;
  signal = signal(:);
  signal = signal / max(abs(signal));
endfunction

