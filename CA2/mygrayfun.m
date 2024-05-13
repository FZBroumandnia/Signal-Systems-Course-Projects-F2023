function outPic = mygrayfun(picture)
    coef=[0.299, 0.578, 0.114];
    Rpart = coef(1).*picture(:,:,1);
    Bpart = coef(2).*picture(:,:,2);
    Gpart = coef(3).*picture(:,:,3);
    outPic= Rpart+Bpart+Gpart;
end
