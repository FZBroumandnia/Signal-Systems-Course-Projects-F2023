clc, clear, close all
[music, fs] = audioread('loveStory.wav');

keyFrequencies = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77];
keyNames = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};

fs = 8000;
Ts = 1/fs;
T = 0.50;
tau = 0.025;
t_start = 0;
t_end1 = T;
t_end2 = T/2;
t1 = t_start:Ts:t_end1-Ts;
t2 = t_start:Ts:t_end2-Ts;
pauseTime = t_start:Ts:tau-Ts;
pauseTime=zeros(1,length(pauseTime)+1);

index = strfind(music', pauseTime);

threshold = 0.02;

detectedNotes = [];
detectedDurations = [];

stepSize1 = length(t1) + length(pauseTime);
stepSize2 = length(t1) + length(pauseTime);

chunkStart = 1;
m=1;
while chunkStart <= length(music)
    if(m>length(index))
        break;
    elseif(m==length(index))
        chunkEnd = length(music);
    else
        chunkEnd = index(m);
    end
    chunk = music(chunkStart:chunkEnd, 1);
    
    N = length(chunk);
    frequencies = (0:N-1) * fs / N;
    fft_result = fft(chunk, N);
    magnitude_spectrum = abs(fft_result);
    
    [~, idx] = max(magnitude_spectrum);
    dominant_frequency = frequencies(idx);
    
    [~, keyIndex] = min(abs(keyFrequencies - dominant_frequency));
    detectedNote = keyNames{keyIndex};
    difference_t1 = abs(chunkEnd - chunkStart - length(t1));
    difference_t2 = abs(chunkEnd - chunkStart - length(t2));
    
    if difference_t1 <= difference_t2
        detectedDuration = 1;
    else
        detectedDuration = 2;
    end 
    
    detectedNotes = [detectedNotes, detectedNote];
    detectedDurations = [detectedDurations,detectedDuration];
    
    
    chunkStart = index(m) +length(pauseTime)+1;
    m=m+1;
end


disp('Detected Notes:');
disp(detectedNotes);

disp('Detected Durations:');
disp(detectedDurations);
