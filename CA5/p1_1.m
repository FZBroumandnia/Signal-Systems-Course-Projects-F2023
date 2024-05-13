clc,close all
fs=50;

tstart=-1;
tend=1;
T=tend-tstart;
N=T*fs;
t=tstart:1/fs:tend;
x1=cos(10*pi*t);

plot(t,x1);
title('cos(10\pi t)')

figure

y=fftshift(fft(x1));
F=y/max(abs(y));

f=-(fs/2):(fs/N):(fs/2)-(fs/N);
f=[f f(1)]
plot(f,abs(F));
title('fourier transform cos(10\pi t)')

