function msg=decoding_amp(signal,mapset,bitrate)
Fs=100;
Ts=1/Fs;
Ton=1;
chunk = round(Ton * Fs);
t=0:Ts:Ton;

binMsg='';
threshold = 2*(2^bitrate-1); 

fraction_arr=[];
for i=0:1:(2^bitrate-1)
    fraction=i/(2^bitrate-1);
    fraction_arr = [fraction_arr fraction];
end

for i = 1:chunk:(length(signal) - chunk)
    sig_part = signal(i:i+chunk-1);    
    
        template = 2*sin(2*pi*t);
        correlation = max(0.01*xcorr(sig_part, template));
    m=abs(fraction_arr - correlation);
    [u, idx] = min(abs(fraction_arr - correlation));

     if threshold > u
        binMsg=strcat(binMsg,dec2bin(idx-1,bitrate));
     else
         binMsg=strcat(binMsg,'?');
     end
end

lenMsg=length(binMsg)/5;
idx=[];
for i=1:lenMsg
    idx=[idx, find(strcmp(binMsg(5*i-4:5*i),mapset(2,:))==1) ];
end
msg=cell2mat(mapset(1,idx));

end
