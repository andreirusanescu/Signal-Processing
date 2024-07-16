function _ = plot_spectrogram(S, f, t, window_title)
  figure('Name', window_title);
  % We use log cuz that's how human hearing works!
  imagesc(t, f, log10(S));
  axis xy;
  xlabel('Time (s)');
  ylabel('Frequency (Hz)');
  title('Spectrogram');
  colormap('jet');
endfunction

