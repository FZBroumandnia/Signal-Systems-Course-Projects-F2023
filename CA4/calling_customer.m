function calling_customer(num,room)

if num>99 | num<1 | room>9 | room<1
    error("input numbers are not in the range")
else
    load TRAININGSET;
    
    
    shomareIdx=find(strcmp('S',TRAIN(2,:))==1);
    bajeIdx=find(strcmp('B',TRAIN(2,:))==1);
    oIdx=find(strcmp('O',TRAIN(2,:))==1);
    NUM=[];
    if(num>19 & rem(num,10)==0)
        numIdx=find(strcmp(num2str(num),TRAIN(2,:))==1);
        NUM=TRAIN{1,numIdx}';
    elseif(num<20)
          numIdx=find(strcmp(num2str(num),TRAIN(2,:))==1);  
          NUM=TRAIN{1,numIdx}';
        else
        numIdxFDigit=find(strcmp(num2str(floor(num/10)*10),TRAIN(2,:))==1);
        numIdxSDigit=find(strcmp(num2str(rem(num,10)),TRAIN(2,:))==1);
        NUM=[TRAIN{1,numIdxFDigit}' TRAIN{1,oIdx}' TRAIN{1,numIdxSDigit}'];
    end
    
    roomIdx=find(strcmp(num2str(room),TRAIN(2,:))==1);
    Y=[TRAIN{1,shomareIdx}' NUM TRAIN{1,bajeIdx}' TRAIN{1,roomIdx}'];
    sound(Y, 44100);
end
end
