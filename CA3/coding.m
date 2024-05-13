function outPic=coding(msg,pic,mapset)
idx=[];
for i=1:length(msg)
    ch=msg(i);
    idx=[idx, find(strcmp(ch,mapset(1,:))==1)];
end
binMsg=cell2mat(mapset(2,idx));
outPic=pic;
for i=1:length(binMsg)
    num=dec2bin(pic(i),8);
    num(8)=binMsg(i);
    outPic(i)=bin2dec(num);
end
end
