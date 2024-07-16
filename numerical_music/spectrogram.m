function [S f t] = spectrogram(signal, fs, window_size)
	% fs = sampling frequency
	signal_len = length(signal);
	% number of windows:
	windows_no = floor(signal_len / window_size);
	S = zeros(window_size, windows_no);

	% frequency vector:
	f = ((0 : (window_size - 1)) * fs / (2 * window_size))';
	% sampling period is 1 / fs

	% time vector:
	t = ((0 : (windows_no - 1)) * window_size / fs)';
	% hanning is applied on the window length
	window = hanning(window_size);
	for i = 1 : windows_no
		% start index
		st = (i - 1) * window_size + 1;
		% end index of the window
		end_ = st + window_size - 1;

		windowed_signal = signal(st : end_) .* window;
		windowed_fft = fft(windowed_signal, 2 * window_size);
		windowed_fft = abs(windowed_fft(1 : window_size));

		S(:, i) = windowed_fft;
	endfor
endfunction

