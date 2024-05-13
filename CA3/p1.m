pic=imread('a.jpg');
pic=rgb2gray(pic);
%pic=imresize(pic,0.3);
subplot(1,2,1);
%imshow(pic(1:10))

imshow(pic)
Alphabet='abcdefghijklmnopqrstuvwxyz .,!";';

numChar=length(Alphabet);
mapset=cell(2,numChar);
for i=1:numChar
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
msg='hello session signal;';

outPic=coding(msg,pic,mapset);
subplot(1,2,2);
%imshow(outPic(1:10));
imshow(outPic);

decodedMsg=decoding(outPic,mapset)