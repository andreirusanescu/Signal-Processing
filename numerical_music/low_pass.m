function signal = low_pass(x, fs, cutoff_freq)
  % compute FFT of signal x:
	x_fft = fft(x);
	% compute the length of the signal
	signal_length = length(x_fft);
	% compute all possible frequencies of the signal
	all_fs = ((0 : signal_length - 1) * fs / signal_length)';
	% create mask vector
	mask = all_fs <= cutoff_freq;
	% get the filtered signal
	fsig_fft = x_fft .* mask;
	% inverse FFT:
	% extracting the filtered signal from the fft
	signal = ifft(fsig_fft);
	% normalize the signal
	signal = signal / max(abs(signal));
endfunction

