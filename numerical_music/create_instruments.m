function instrument_map = create_instruments(file, fs, num_instruments)
  instruments = cell(num_instruments, 7);

  for i = 1 : num_instruments
    line = fgetl(file);
    instruments(i, :) = strtrim(strsplit(line, ','));
  endfor

  instrument_map = containers.Map('KeyType', 'char', 'ValueType', 'any');

  for i = 1 : num_instruments
    name = char(instruments{i, 1});
    freq = str2num(instruments{i, 2});
    duration = str2num(instruments{i, 3});
    attack = str2num(instruments{i, 4});
    decay = str2num(instruments{i, 5});
    sustain = str2num(instruments{i, 6});
    release = str2num(instruments{i, 7});

    osc = oscillator(freq, fs, duration, attack, decay, sustain, release);

    instrument_map(name) = osc;
  endfor
endfunction

