function outPic = mybinaryfun(picture,threshold)
    th=threshold*ones(size(picture));
    outPic= (picture > th);
    
end
