close all
Alphabet='abcdefghijklmnopqrstuvwxyz .,!";';

numChar=length(Alphabet);
mapset=cell(2,numChar);
for i=1:numChar
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
msg='signal';
bitRate=3;
outSig=coding_amp(msg,mapset,bitRate);
plot(1:length(outSig),outSig);
decodedMsg=decoding_amp(outSig,mapset,bitRate);


%%%%%%%%%%%%%%%% part 1-5
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


%%%%%%%%%%%%%%%% part 1-6

bitRate=3;
coef=0.001;
outSig=coding_amp(msg,mapset,bitRate);
noise=coef*randn(1,length(outSig));
noisySig=noise+outSig;
plot(1:length(noisySig),noisySig);
close all;
decodedNoisyMsg1=decoding_amp(noisySig,mapset,bitRate)
m=0
outSig=coding_amp(msg,mapset,1);
decodedNoisyMsg1=decoding_amp(outSig,mapset,1);

