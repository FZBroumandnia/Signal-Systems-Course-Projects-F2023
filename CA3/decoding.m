function msg=decoding(pic,mapset)

binMsg='';
terminateChar=';';
terminateCharBin=dec2bin(find(strcmp(terminateChar,mapset(1,:))==1)-1);

for i=1:numel(pic)
    num=dec2bin(pic(i),8);
    binMsg=strcat(binMsg,num(8));
    if(rem(i,5)==0)
        if(binMsg(end-4:end)==terminateCharBin)
            break;
        end
    end
end

lenMsg=length(binMsg)/5;
idx=[];
for i=1:lenMsg
    idx=[idx, find(strcmp(binMsg(5*i-4:5*i),mapset(2,:))==1) ];
end
msg=cell2mat(mapset(1,idx));
end