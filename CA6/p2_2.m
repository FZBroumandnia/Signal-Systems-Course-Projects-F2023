clc, clear, close all
fs = 8000;       
Ts = 1/fs;       
T = 0.50;         
tau = 0.025;     

keyFrequencies = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77];

keyNames = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};

userKeys = {'E', 'E', 'E', 'E', 'E', 'E', 'E', 'G', 'C', 'D', 'E', 'F', 'F', 'F', 'F', 'F', 'E', 'E', 'E', 'E', 'D', 'D', 'E', 'D', 'G'};

noteDurations = ones(1,length(userKeys));
noteDurations(2)=2;

t_start = 0;
t_end1 = T;
t_end2 = T/2;
t1 = t_start:Ts:t_end1-Ts;
t2 = t_start:Ts:t_end2-Ts;
pauseTime=t_start:Ts:tau-Ts;
pauseTime=zeros(1,length(pauseTime));

music = [];
for i = 1:length(userKeys)
    keyName = userKeys{i};
    
    keyIndex = find(strcmp(keyNames, keyName));
    if ~isempty(keyIndex)
        frequency = keyFrequencies(keyIndex);
        duration = noteDurations(i);
        
        if duration == 1
            signal = sin(2*pi*frequency*t1);
        else
            signal = sin(2*pi*frequency*t2);
        end

        music = [music signal pauseTime];
    else
        disp(['Invalid key name: ' keyName]);
    end
end
plot(length(music),music);
sound(music, fs);
audiowrite('mysong.wav',music,fs);

t = (0:length(signal)-1) * Ts;
figure;
plot(t(1:2000), signal(1:2000), 'b');
info = audioinfo('mysong.wav');
bitDepth = info.BitsPerSample;
disp(['my song uses ' num2str(bitDepth) ' bits per sample.']);
 
N=fs;
f=0:fs/N:(fs/2) - fs/N;

    y=fftshift(fft(music));
    F=y/max(abs(y));
%     f=-(fs/2):(fs/N):(fs/2)-(fs/N);
    maxVal = max(abs(F));
    row = find(abs(F) == maxVal, 1, 'last');
    noteFrequency= f(row)
    plot(f,F(1:4000));
