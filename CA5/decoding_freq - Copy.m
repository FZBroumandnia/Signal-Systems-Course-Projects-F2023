function msg=decoding_freq(signal,mapset,bitrate)
Fs=100;
fs=100;
N=100;
Ts=1/Fs;
Ton=1;
chunk = round(Ton * Fs);
t=0:Ts:Ton;

binMsg='';
threshold = 2*(2^bitrate-1); 

assigned_freq_arr=[];
Threshold_arr=[];
 
 f=0:fs/N:(fs/2) - fs/N;
chunk1=length(f)/(2^bitrate);
chunk2=length(f)/((2^bitrate) * 2);
for i=0:1:(2^bitrate-1)
    
    assigned_freq=chunk1*i+chunk2;
    assigned_freq_arr = [assigned_freq_arr assigned_freq];
    Threshold_arr=[Threshold_arr chunk1*i];
end
Threshold_arr=[Threshold_arr N/2];

for i = 1:chunk:(length(signal) - chunk)
    sig_part = signal(i:i+chunk-1);    
    y=fftshift(fft(sig_part));
    F=y/max(abs(y));
    f=-(fs/2):(fs/N):(fs/2)-(fs/N);
   
    figure
    plot(f,abs(F));
    maxVal = max(abs(F));
    row = find(abs(F) == maxVal);
    mat=f(row);    
    found_freq= mat(mat>0);
    decoded_bits = 0;
    for i=(2^bitrate+1):-1:1
        if Threshold_arr(i) <= found_freq    
            decoded_bits = i -1;
            break;
        end
    end
    binMsg=strcat(binMsg,dec2bin(decoded_bits,bitrate));
end

lenMsg=length(binMsg)/5;
idx=[];
for i=1:lenMsg
    idx=[idx, find(strcmp(binMsg(5*i-4:5*i),mapset(2,:))==1) ];
end
msg=cell2mat(mapset(1,idx));

end



function msg=decoding_freq(signal,mapset,bitrate)
Fs=100;
fs=100;
N=100;
Ts=1/Fs;
Ton=1;
chunk = round(Ton * Fs);
t=0:Ts:Ton;

binMsg='';
threshold = 2*(2^bitrate-1); 

assigned_freq_arr=[];
Threshold_arr=[];
 
 f=0:fs/N:(fs/2) - fs/N;
chunk1=floor(length(f)/(2^bitrate));
chunk2=ceil(length(f)/((2^bitrate) * 2));
for i=0:1:(2^bitrate)
    
    assigned_freq=chunk1*i+chunk2;
    assigned_freq_arr = [assigned_freq_arr assigned_freq];
    Threshold_arr=[Threshold_arr chunk1*i];
end

for i = 1:chunk:(length(signal) - chunk)
    sig_part = signal(i:i+chunk-1);    
    y=fftshift(fft(sig_part));
    F=y/max(abs(y));
    f=-(fs/2):(fs/N):(fs/2)-(fs/N);
   
    figure
    plot(f,abs(F));
    maxVal = max(abs(F));
    row = find(abs(F) == maxVal, 1, 'last');
    found_freq= f(row);
    decoded_bits = find(Threshold_arr <= found_freq, 1, 'last');
    binMsg=strcat(binMsg,dec2bin(decoded_bits-1,bitrate));
end

lenMsg=length(binMsg)/5;
idx=[];
for i=1:lenMsg
    idx=[idx, find(strcmp(binMsg(5*i-4:5*i),mapset(2,:))==1) ];
end
msg=cell2mat(mapset(1,idx));

end

