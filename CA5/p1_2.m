clc,close all
fs = 100;
t_start = 0;
t_end = 1;
ts = 1 / fs;
t = t_start:ts:t_end - ts;
N = length(t);
f = (-fs / 2):(fs / N):(fs / 2 - fs / N);
x1=cos((30*pi*t)+(pi/4));

plot(t,x1);
title('cos((30 \pi t)+ (\pi/4))')

figure

y=fftshift(fft(x1));
F=y/max(abs(y));

subplot(1,2,1);
plot(f,abs(F));
title('abs cos((30 \pi t)+ (\pi/4))')
subplot(1,2,2);

to1=1e-6;
F(abs(F)<to1)=0;
theta = angle(F);
plot(f,theta/pi);
title('angle cos((30 \pi t)+ (\pi/4))')
xlabel('Frequency (Hz)');
ylabel('Phase/ \pi');


