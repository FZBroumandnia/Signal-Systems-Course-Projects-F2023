subplot(1,3,1);
plot(t,x);
title('x(t)');
xlabel('t')
ylabel('x')
grid on

subplot(1,3,2);
plot(t,y);
title('y(t)');
xlabel('t')
ylabel('y')
grid on

subplot(1,3,3);
plot(x,y,'.');
title('x y');
xlabel('x')
ylabel('y')
grid on