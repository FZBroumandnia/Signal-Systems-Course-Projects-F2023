
function signal=coding_freq(msg,mapset,bitrate)
idx=[]; Y=[];
for i=1:length(msg)
    ch=msg(i);
    idx=[idx, find(strcmp(ch,mapset(1,:))==1)];
end
binMsg=cell2mat(mapset(2,idx));
fs=100;
N=100;
T=1; Ts=1/fs; Ton=1;
t=0:Ts:Ton;
f=0:fs/N:(fs/2) - fs/N;
chunk1=length(f)/(2^bitrate);
chunk2=length(f)/((2^bitrate) * 2);
Threshold_arr=[];
for i=0:1:(2^bitrate)
    Threshold_arr=[Threshold_arr chunk1*i];
end

for i=1:bitrate:length(binMsg)
    fr=chunk1*bin2dec(binMsg(i:i+bitrate-1))+chunk2;
    y=sin(2*pi*fr*t);
     plot(1:length(y),y);
    Y=[Y y];
end
Y;
plot(1:length(Y),Y);
signal=Y;
end