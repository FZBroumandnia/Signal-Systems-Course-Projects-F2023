clc, clear, close all
ts=1e-9;
T=1e-5;
tau=1e-6;



t=0:ts:T;
tlen=length(t);
x=zeros(1,tlen);
t2=0:ts:tau;
x(1:length(t2))=ones(1,length(t2));
plot(t,x);
title('sent signal');
xlim([0, T]);
ylim([-1, 2]);
xlabel('time')
ylabel('amplitude')

R=450;
lightSpeed=3e+8;
index=2*R/lightSpeed;
td=0:ts:index;

y=zeros(1,tlen);
t2=0:ts:tau;
y(length(td):length(td)+length(t2))=0.5;
figure
plot(t,y);
title('recieved signal');
xlim([0, T]);
ylim([-1, 2]);
xlabel('time')
ylabel('amplitude')

    




ro=zeros(1,tlen);
for i=1:tlen
    temp=zeros(1,tlen);
    temp(i:i+length(t2))=1;
    for j=1:tlen
        ro(i)=ro(i)+y(j)*temp(j);
    end
end
figure
plot(t,ro);
[maximum,idx]=max(ro)
distance=t(idx)*lightSpeed/2

