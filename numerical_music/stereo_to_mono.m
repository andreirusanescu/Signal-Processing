function mono = stereo_to_mono(stereo)
  mono = mean(stereo, 2);
  % normalize
  mono = mono / max(abs(mono));
endfunction

