function x = oscillator(freq, fs, dur, A, D, S, R)
  % compute the time vector:
  t = (0 : 1 / fs : dur - 1 / fs)';

  x = sin(2 * pi * freq * t);

  % the level * sampling rate
  attack_samples = floor(A * fs);
  decay_samples = floor(D * fs);
  release_samples = floor(R * fs);
  sustain_samples = dur * fs - attack_samples - decay_samples - release_samples;

  % linear ramp from 0 to 1 applied over attack_samples
  attack_envelope = linspace(0, 1, attack_samples)';
  decay_envelope = linspace(1, S, decay_samples)';

  % making sure the constant is an integer
  ct = round(sustain_samples);
  sustain_envelope = ones(ct, 1) * S;
  release_envelope = linspace(S, 0, release_samples)';
  
  envelope = [attack_envelope; decay_envelope; sustain_envelope; release_envelope];
  x = x .* envelope;
endfunction

