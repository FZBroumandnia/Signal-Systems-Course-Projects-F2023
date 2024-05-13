clc, clear, close all
fs = 8000;       
Ts = 1/fs;       
T = 0.50;         
tau = 0.025;     

keyFrequencies = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77];

keyNames = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};

userKeys = {'D' 'D' 'G' 'F#' 'D' 'D' 'E' 'E' 'D' 'F#' 'D' 'E' 'D' 'E' 'F#' 'E' 'D' 'E' 'E' 'D' 'F#' 'D' 'E' 'D' 'E' 'D' 'F#' 'E'  'D' 'E' 'D' 'F#' 'E' 'D' 'D' 'E' 'F#' 'E' 'F#' 'F#' 'E' 'F#' 'F#' 'D'};
noteDurations = [1 1 2 2 1 1 1 1 1 1 1 2 2 2 2 2 1 1 1 1 1 1 2 2 1 1 2 2 2 1 1 2 2 1 1 2 1 1 2 1 1 2 2 2 1 1 2 2 2];

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
            signal = sin(2*pi*frequency*t2);
        else
            signal = sin(2*pi*frequency*t1);
        end

        music = [music signal pauseTime];
    else
        disp(['Invalid key name: ' keyName]);
    end
end
sound(music, fs);
audiowrite('loveStory.wav',music,fs);
