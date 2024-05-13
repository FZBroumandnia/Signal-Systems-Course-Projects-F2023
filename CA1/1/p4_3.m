function p4_3(x,fs,speed)
if speed == 2
    y=x(1:2:length(x));
    sound(y, fs)
elseif speed==0.5
    m(1:2:2*length(x))=x(1:length(x));
    inbet=(x(1:length(x)-1)+x(2:length(x)))./2;
    m(2:2:2*length(x)-1)=inbet(1:length(x)-1);
    sound(m, fs)
else
    error('wrong input')
end
end