clc
close all;
clear;
tic;
% SELECTING THE TEST DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure
subplot(1,2,1)
imshow(picture)
picture=imresize(picture,[600 800]);
subplot(1,2,2)
imshow(picture)

%RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture=rgb2gray(picture);
figure
subplot(1,2,1)
imshow(picture)

% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = graythresh(picture);
picture =~imbinarize(picture,threshold);
subplot(1,2,2)
imshow(picture)

% Removing the small objects and background
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
picture = bwareaopen(picture,60); % removes all connected components (objects) that have fewer than 500 pixels from the binary image
subplot(1,3,1)
imshow(picture)
background=bwareaopen(picture,1670);
subplot(1,3,2)
imshow(background)
picture2=picture-background;
subplot(1,3,3)
imshow(picture2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%jolobandi%%%%%%%%%%%%%%%%%

rowDiff=sum(abs([picture2(:,2:size(picture2,2)) repmat(picture2(:,size(picture2,2)),1,1)]-picture2(:,:)),2);
[maxRowDiff, maxRowDiffIdx]=max(rowDiff(300:500))
maxRowDiffIdx=maxRowDiffIdx+300;

topArr=find(abs(rowDiff(maxRowDiffIdx-50:maxRowDiffIdx)-repmat(maxRowDiff,51,1))<20);
top=maxRowDiffIdx-50+topArr(1);

bottomArr=find(abs(rowDiff(maxRowDiffIdx:maxRowDiffIdx+50)-repmat(maxRowDiff,51,1))<20);
bottom=maxRowDiffIdx+bottomArr(length(bottomArr));


colDiff=sum(abs([picture2(2:size(picture2,1),:) ; repmat(picture2(size(picture2,1),:),1,1)]-picture2(:,:)),1);
[maxColDiff, maxColDiffIdx]=max(colDiff(300:400))
maxColDiffIdx=maxColDiffIdx+300;

leftArr=find(abs(colDiff(1,maxColDiffIdx-230:maxColDiffIdx)-repmat(maxColDiff,1,231))<30);
left=maxColDiffIdx-230+leftArr(1);

rightArr=find(abs(colDiff(1,maxColDiffIdx:maxColDiffIdx+300)-repmat(maxColDiff,1,301))<30);
right=maxColDiffIdx+rightArr(length(rightArr));

figure
imshow(picture2(top:bottom,left:right));
picture2=picture2(top:bottom,left:right);

picture2 = myremovecom(picture2,170);
figure
imshow(picture2)

%%
% Labeling connected components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
imshow(picture2)
[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off



% Decision Making
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Loading the mapset
load TRAININGSETFARSI;
totalLetters=size(TRAIN,2);


figure
final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=picture2(min(r):max(r),min(c):max(c));
    imshow(Y)
    %Y=imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)
    
    %%
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},imresize(Y,size(TRAIN{1,k})));
    end
%%
    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(TRAIN(2,pos));       
        final_output=[final_output out];
    end
end



% Printing the plate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = fopen('farsi_number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);

winopen('farsi_number_Plate.txt')
toc