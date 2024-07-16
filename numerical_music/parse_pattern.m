function pattern = parse_pattern(file, fs, bpm, instrument_map)
  samples_per_beat = 60 * fs / bpm;
  samples_per_minibeat = samples_per_beat / 4;

  raw_pattern = fgetl(file);
  raw_pattern = strsplit(raw_pattern, ',');
  raw_pattern = strtrim(raw_pattern);
  num_minibeats = length(raw_pattern);

  pattern = zeros(1, samples_per_minibeat * num_minibeats);

  for i = 1 : num_minibeats
    curr = (i - 1) * samples_per_minibeat + 1;
    if strcmp(raw_pattern{i}, '_')
      continue;
    endif

    instrument = instrument_map(raw_pattern{i});

    e = curr + length(instrument);
    if length(pattern) < curr + length(instrument);
      pattern = [pattern zeros(1, curr + length(instrument) - length(pattern))];
    endif
    pattern(curr : curr + length(instrument) - 1) = instrument;
  endfor
endfunction

