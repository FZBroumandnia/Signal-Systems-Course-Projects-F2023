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


figure
conv_result=conv(y,x);
conv_result=conv_result(1:10001);
plot(t,conv_result);
title('convolve result');

[maximum2,idx2]=max(conv_result)
distance=(t(idx2)-tau)*lightSpeed/2


%%%%%%%%%%%%%%%%%%%% Part 2-3
Threshold=10;
for coef=0.1:0.1:10
    noise=coef*rand(1,tlen);
    z=y+noise;
    
    conv_result=conv(z,x);
    conv_result=conv_result(1:10001);
    title('convolve result');
    
    [maximum2,idx2]=max(conv_result);
    
    distance=(t(idx2)-tau)*lightSpeed/2;
    if(abs(distance-R)>Threshold)
        coef
        break
    end
end
