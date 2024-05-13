clc, clear, close all
[y, Fs] = audioread('a.wav');
figure
plot(1:length(y),y)


Ton=0.1;
Toff=0.1;
dtmf = round(Ton * Fs);
silence=round(Toff*Fs);

threshold = 0.2; 
dtmf_keys = ['1', '2', '3'; '4', '5', '6'; '7', '8', '9'; '*', '0', '#'];

fr = [697, 770, 852, 941];
% row_tone=zeros(1,length(fr));
% for k=1:length(fr)
%     row_tone(k) = (sin(2 * pi * fr(k) * (0:dtmf) / Fs))';
% end
fc = [1209, 1336, 1477];
% col_tone=zeros(1,length(fc));
% for k=1:length(fc)
%     col_tone(k) = (sin(2 * pi * fc(k) * (0:dtmf) / Fs))';
% end
detected_keys = '';

for i = 1:silence+dtmf:(length(y) - silence)
    audio_part = y(i:i+dtmf);    
    
    for j = 1:length(fc)
        col_tone = sin(2*pi*fc(j)*(0:dtmf)/Fs);
        col_correlations(j) = max(xcorr(audio_part, col_tone));
    end

    for j = 1:length(fr)
        row_tone = sin(2*pi*fr(j)*(0:dtmf)/Fs);
        row_correlations(j) = max(xcorr(audio_part, row_tone));
    end

    [u, row_idx] = max(row_correlations);
    [u, col_idx] = max(col_correlations);

    if row_correlations(row_idx) > threshold && col_correlations(col_idx) > threshold
        detected_keys = [detected_keys, dtmf_keys(row_idx, col_idx)];
    end
end

detected_keys