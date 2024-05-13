clc, clear, close all
fs = 20;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = 0:(fs / N):((N - 1) * fs / N);
x1 = exp(1j * 2 * pi * 5 * t) + exp(1j * 2 * pi * 8 * t);
figure
plot(f, abs(fft(x1)) / max(abs(fft(x1))))
xlabel('freq (Hz)')
title('Fourier Transform of x1')


x2 = exp(1j * 2 * pi * 5 * t) + exp(1j * 2 * pi * 5.1 * t);
figure
plot(f, abs(fft(x2)) / max(abs(fft(x2))))
xlabel('freq (Hz)')
title('Fourier Transform of x2')

