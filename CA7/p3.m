syms y(t) x(t) 
Dy = diff(y);

x(t)=5 * step(tf(1,1));
ode = diff(y,t,2)+ 3*diff(y,t,1)+2*y == 5 * step(tf(1,1));

cond1 = y(0) == 1;
cond2 = Dy(0) == 1;
conds = [cond1 cond2];
ySol(t) = dsolve(ode,conds);
ySol = simplify(ySol)

m=0:0.05:10;
plot(m, ySol(m));  
title('Solution of the Differential Equation Part 3');
xlabel('Time (t)');
ylabel('y(t)');
grid on;