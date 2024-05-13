clear, close all
Alphabet='abcdefghijklmnopqrstuvwxyz .,!";';

numChar=length(Alphabet);
mapset=cell(2,numChar);
for i=1:numChar
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
msg='signal';
bitRate=5;
outSig=coding_freq(msg,mapset,bitRate);
figure
plot(1:length(outSig),outSig);
title1=sprintf('bitrate=%d', bitRate);
title(title1);
decodedMsg=decoding_freq(outSig,mapset,bitRate);


%%%%%%%%%%%%%%%% making random signal
data = randn(1,3000);
histogram(data, 'Normalization', 'pdf');
hold on;
x = -4:0.1:4;
y = normpdf(x, 0, 1);
plot(x, y, 'r', 'LineWidth', 2);
mu = mean(data); 
sigma = std(data); 
disp(['mean: ', num2str(mu)]);
disp(['variance', num2str(sigma^2)]);


%%%%%%%%%%%%%%%% part 2-5

bitRate=1;
coef=sqrt(1.5);
outSig=coding_freq(msg,mapset,bitRate);
noise=coef*randn(1,length(outSig));
noisySig=noise+outSig;
plot(1:length(noisySig),noisySig);
decodedNoisyMsg1=decoding_freq(noisySig,mapset,bitRate)


