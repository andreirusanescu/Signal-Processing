# 313CC Rusanescu Andrei-Marian

Task 1 - Numerical Music

This task is all about frequencies, signal processing, sound editing
playing with sounds and creating music.
Audio can be stored as stereo signals or mono signals, but due to the
fact that mono audio is easier to implement, having only one channel,
mono audio is the preferred version.
The first function takes in a stereo audio and makes a mean for each
column, converting the audio to mono, which is normalized afterwards.

Spectogram

The frequency vector contains all the frequencies present in the signal
based on the window size and sampling frequency. Since the Fourier
Transform is symmetric, the frequency is computed taking only half
of the window size. 

The time vector is computed for each sequence of time like this:
the time between each window is the size of the window divided
by the sampling frequency.

Hanning function returns the hann window, a column vector. Hann window 
is applied to each window. FFT is then applied with a resolution twice
the size of the window size. Then the absolute value of each complex
number is extracted from the windowed_fft column vector and added
to the matrix.

Oscillator

The envelope is described by 4 parameters: attack, decay, sustain,
release and its purpose is to describe the amplitude of a signal.
In this case it was generated using linear ramps.
This function takes in 7 arguments:
    - freq = frequency;
    - fs = sampling frequency;
    - dur = duration;
    - A = time until the sound reaches maximum amplitude;
    - D = time until the sound reaches sustain level from maximum 
          level;
    - S = Sustain, the amplitude level
    - R = Release


Low Pass

The purpose of the function is to remove the parts of the signal with a
frequency beyond a cuttoff_frequency. In order to do that, the fft is
applied to the signal. Then a mask of ones and zeros is computed using
all the frequencies of the signal and the cutoff frequency. If the
frequency is lower than the cutoff, the mask is 1 at that index. Then
this mask is applied to the fft signal. To get back to the original, now
filtered signal, the Inverse Fast Fourier Transform is applied to the
filtered signal. Then, the signal is normalized.

Reverb

The reverberated signal is a convolution between the signal and an impulse
response. The new signal is then normalized.


Comments on the graphs:

- Plain Loop and Plain Sound:
The difference consists in the frequencies that both sounds contain. Plain
Loop is a more smoother sound with ups and downs, while plain sound is like
a hee - hat, where hee is a very sharp sound and the hat is like a thud, a
muffled noise. The graph eloquently shows how the sound is produced at fixed
intervals of time in the Plain sound file.

- Low Pass Sound vs Plain Sound:
The low pass sound one is the plain sound one with a low pass filter applied.
The hee - hats can no longer be heard. The figure of the low pass sound is 
massively smoothened out, compared to its original version.

- Reverb Sound vs Plain Sound.
The difference consists in the effect of space simulated by the Reverb Sound
file. The sound is 'delayed', or repeated, due tot the convolution with an
impulse response. This creates the effect of space. All the frequencies are
heard for longer periods of time, thus the lack of blue color in the graph,
there is not enough time to not hear anything. The lower tones can be heard
in the end as a ringing echo.

- Tech
The sound starts somewhere in the middle of a drop. This can be seen around
second 9 in the graph. The first 9 seconds are to be repeated. The bass can
be heard in the audio file and seen as the very red parts at the surface
of the graph (frequency ranging between 60 to 250Hz), while the ringing of
the drums have a higher frequency and can be seen as the spikes of redness.

- Low Pass Tech
After the low pass filter was applied, the ringing of the drums can no
longer be heard, thus the spikes of redness can no longer be seen. The
filter gives a sound similar to a muffled thud.

- Reverb Tech
As in the case of the Reverb Sound file, a similar effect occurs here.
Both the higher and lower frequencies are 'delayed' 'populating' the
graph more. In the end, a fading sound effect occurs. Also, the sound
is more evenly spread out, due to its echoing nature.

- Low Pass Tech + Reverb
The reverb effect is applied to the low pass version of the tech sound,
which contained the lower frequencies of the sound. This can be seen
in the Spectogram as the congested redness on the bottom, having no
higher frequencies to be reverberated. The reverberating fading nature
can be seen in the end of the sample.

- Reverb + Low Pass Tech
This one sounds quite similarly to the previous sound, only it doesn't
have the same overall smoothness and fading in the end, because of the
low pass filter that modified the frequencies 'natural' fading.



Task 2 - Robotzii

Spline C2

This function takes in 2 vectors: x and y. Vector y contains the 
values of the function calculated in the points contained in x.
The size of x is m, therefore the number of Spline functions would
be m - 1. 
The Spline function is declared as a 3D vector. The first index is
associated with the number of the Spline function. The second 
index represents the x wherein is the function is computed
(e.g. s(i, 1, :) - s_i(x_i), s(i, 2, :) - s_i(x_i+1)). The third
index corresponds to the coefficient in the Spline function
(s(i, 1, 1) = a_i, s(i, 1, 2) = b_i). Having a total of m - 1
Spline functions => 4 * (m - 1) equations (m is the length of
the vector x), therefore the matrix of coefficients is the size
of 4 * (m - 1) x 4 * (m - 1). For simplicity, say n = m - 1.
So there are 4n equations with 4n coefficients to be found.

Firstly, there are n + 1 equations like so: 
    - n equations s_i(x_i) = y_i;
    - one last equation s_n-1(x_n) = y(n).

Secondly, there are 3(n - 1) equations like this:
    - (n - 1) s_i(x_i+1) = s_i+1(x_i+1);
    - (n - 1) s_i'(x_i+1) = s_i+1'(x_i+1);
    - (n - 1) s_i''(x_i+1) = s_i+1''(x_i+1);

Owing to the fact that the Spline functions are cubic, the first
derivative and second derivative can be calculated quite easily.
In the for loop, aux contains the values of s_i'(x_i+1) and tmp
the values of s_i''(x_i+1).

In the end, the last two equations, specific to natural Spline
interpolation, are loaded in the matrix.
The vector of coefficients is computed using A \ b, so octave
uses the fastest way to find the solution.


P Spline

Given a vector of points to be interpolated, the function
should return the value of the spline functions calculated in
each point. All the points between x(i) <= x_interp(j) <= x(i + 1),
are calculated using s_i() Spline function. 

Vandermonde and P Vandermonde use a quite similar approach,
only the formulas differ.


Task 3 - Recommendations

Cosine Similarity

Extracts the cosinus value out of the dot product between two
vectors.

The matrix loaded in read_mat is preprocessed so that all user
rows that have strictly less than min reviews are removed.

In order to get the best 'num_recoms' recommendations similar with
the liked theme, SVD is applied to A. This returns U, S and V. To
do this, a similarity array that contains values between [-1, 1] has
to be computed using the cosine similarity function between each
row of the matrix V and the row 'liked_theme'. Because the dot
product between 'liked_theme' with itself does 1, its value has
to be overwritten. So an index array has to be held. Using max, 
the max value and max_index is extracted out of the similarity
array, the max_index being the index of the liked_theme in the
array. Its value is overwritten with -1. Then, a m x 2 matrix that
holds the similarity and index column vectors together is sorted
in descending order considering the first column. The best num_recoms
recommendations are the indexes left in the second column of the matrix.
