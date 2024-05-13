function outPic = myremovecom(picture,n)
    [row, col]=find(picture==1);
    points=[row';col'];

    flagObjNum=1;
    currObjNum=1;
    OBJECT={};
    while size(points,2)>0
        firstPoint=points(:,1);
        points(:,1)=[];
        [points, neighbors] = myFindNeighbors(firstPoint, points);
        currObj=[firstPoint neighbors];
        newPointsLen=size(neighbors,2);
        while newPointsLen>0
            newPointSpare2=[];
            for i=1:newPointsLen
                m=neighbors(:,i);
                [points, newPointSpare] = myFindNeighbors(neighbors(:,i), points);
                newPointSpare2=[newPointSpare2 newPointSpare];
            end
            currObj=[currObj newPointSpare2];
            neighbors=newPointSpare2;
            newPointsLen=size(neighbors,2);
        end
        %OBJECT(currObjNum)=currObj;
        OBJECT=[OBJECT,currObj];
        currObjNum=currObjNum+1;
        %c
    end

    
    currObjNum=currObjNum-1;
    r1=[];
    c1=[];
    for i=1:currObjNum
        if size(OBJECT{1,i},2)<n
            r1=[r1 OBJECT{1,i}(1,:)];
            c1=[c1 OBJECT{1,i}(2,:)];
        end
    end
    index=sub2ind(size(picture),r1,c1);
    outPic=picture;
    outPic(index)=0;
end
