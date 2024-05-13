function [points, neighbors] = myFindNeighbors(firstPoint, points)
    diff=abs(repmat(firstPoint,1,size(points,2))-points);
    neighborIdx=find(diff(1,:)<=1 & diff(2,:)<=1);
    neighbors=points(:, neighborIdx);
    points(:,neighborIdx)=[];

    
end