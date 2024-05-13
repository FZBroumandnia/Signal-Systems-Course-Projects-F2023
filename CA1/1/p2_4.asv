function [a,b]=p2_4(x,y)
    x1=x-mean(x);
    y1=y-mean(y);
    %a=(sum(x1)*sum(y1))/(sum(x1.^2));
    a=(length(x)*sum(x.*y) - sum(x)*sum(y))/(length(x)
    *sum(x.^2)-sum(x.^2));
    b=mean(y)-a*mean(x);
end