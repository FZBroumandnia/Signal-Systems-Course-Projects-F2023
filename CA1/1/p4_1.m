clc, clear
[x,fs] = audioread('hafez.wav');
fs;
sound(x, fs);
t=(0:length(x)-1)/fs;


plot(t,x);
xlabel('time');
audiowrite('x.wav',x,fs);

p4_3(x,fs,0.5)
