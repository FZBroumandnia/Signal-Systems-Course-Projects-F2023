clear;
ts=0.01;
t=0:ts:1;
x=sin(2*pi*t);
subplot(1,2,1);
plot(t,x,'-');
x0=0.5;
y0=0.2;
s='sin(2 \pi t)';
text(x0,y0,s);
title('Sin');
xlabel('amplitude');
ylabel('time');
legend('sin');
grid on

y=cos(2*pi*t);
subplot(1,2,2);
plot(t,y,'Color','r');
x0=0.3;
y0=-0.8;
s='cos(2 \pi t)';
text(x0,y0,s);
title('Cos');
xlabel('amplitude');
ylabel('time');
legend('cos');
grid on
