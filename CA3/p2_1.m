close all
fr = [697 770 852 941];
fc= [1209 1336 1477];
fs=8000;
Ts=1/fs;
Ton=0.1;
Toff=0.1;
t=0:Ts:Ton;
toff=0:Ts:Toff;
keys=['1','2','3','4','5','6','7','8','9','*','0','#'];
Y=[];
input='43218765';
for i=1:1:numel(input)
    idx=find(input(i)==keys);
    k=ceil(idx/3);
    j=rem(idx,3);
    if(j==0)
        j=3;
    end
    y1=sin(2*pi*fr(k)*t);
    y2=sin(2*pi*fc(j)*t);
    y_=(y1+y2)/2;
    Y=[Y y_ toff];
end
sound(Y, fs)
plot(1:length(Y), Y)
audiowrite('y.wav',Y,fs);
