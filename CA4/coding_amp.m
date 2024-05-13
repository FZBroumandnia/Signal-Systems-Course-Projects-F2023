function signal=coding_amp(msg,mapset,bitrate)

idx=[];
for i=1:length(msg)
    ch=msg(i);
    idx=[idx, find(strcmp(ch,mapset(1,:))==1)];
end
binMsg=cell2mat(mapset(2,idx));
fs=100;
Ts=1/fs;
Ton=1;
t=0:Ts:Ton;
Y=[];
for i=1:bitrate:length(binMsg)
    fraction=bin2dec(binMsg(i:i+bitrate-1))/(2^bitrate-1);
    y=fraction.*sin(2*pi*t);
     plot(1:length(y),y);
    Y=[Y y];
end
Y;
plot(1:length(Y),Y);
signal=Y;
end