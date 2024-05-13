clc, clear, close all
load('p2.mat')
t=0:0.001;
plot(t,x)
figure
plot(t,y)

figure
plot(x,y,'.')

[a,b]=p2_4(x,y)

noise=0.1*randn(1,length(y));
z=y+noise;
[a,b]=p2_4(x,z)