function signal = apply_reverb(signal, impulse_response)
  % making sure the impulse response is a mono signal
  impulse_response = stereo_to_mono(impulse_response);
  signal = fftconv(signal, impulse_response);
  signal = signal / max(abs(signal));
endfunction

