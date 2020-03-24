[filename,pathname]=uigetfile('*.SELECT FILE');
I=imread([pathname,filename]);
I2=rgb2gray(I);  %convert image to grayscale
I3 = imresize(I2,[512,512]);%convert image to size of 512 by 512
figure(1);
imshow(I3);

i=fspecial('average');
im=imfilter(medfilt2(I3,[3 3]),i);
figure,imshow(im);

im1 = im;

        
for i = 1:512
    for j = 1:512
        if(im(i,j)>=22.5 && im(i,j)<=224.5)
            im(i,j) = 255;
        else
            im(i,j) = 0;
        end
    end
end

figure(2);
imshow(im);

BW2 = imfill(im,'holes');
figure(3);
imshow(BW2);

SE = strel('disk', 30, 0);
E=imerode(BW2,SE);
figure(4);
imshow(E);

n=E/255;


v = im1.*n;
figure(5);
imshow(v);

fig=im2bw(v);
se=strel('disk',10);
fig2=imerode(fig,se);
lbl=bwlabel(fig2);
props=regionprops(lbl,'Solidity','Area');
solidity=[props.Solidity];
area=[props.Area];
hiSolid = solidity>0.5;
maxArea = max( area(hiSolid));  
hematomaLabel = find( area==maxArea); 
hematoma = ismember(lbl, hematomaLabel);
figure(6);
imshow(hematoma);
hem = imfill(hematoma,'holes');


se = strel('square',10);
exthem = im2uint8(imdilate(hem,se))/255;

figure(8);
hem = exthem.*I3;
imshow(hem);

k= regionprops(hematoma,'Area','MajorAxisLength','MinorAxisLength','Eccentricity','Extent','Perimeter');
L1=k.Area;
L2=k.MajorAxisLength;
L3=k.MinorAxisLength;
L4=k.Eccentricity;
L5=k.Extent;
L6=k.Perimeter;


glcms = graycomatrix(hem);
stats = graycoprops(glcms,{'contrast','homogeneity','Correlation','Energy'});
L7 = mean2(hem);
L8 = std2(hem);
L13=mean2(var(double(hem)));
L9=stats.Contrast;
L10=stats.Homogeneity;
L11=stats.Correlation;
L12=stats.Energy;


T=table(L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13);

R=table(L1,L2,L3,L4,L5,L6);
Y=table2array(R);
B = transpose(Y);

load('combinetrainsvm.mat')
yfit = trainedModel.predictFcn(T);
disp(yfit);

load('combinetrainsvm.mat')
yfit2 = trainedModel1.predictFcn(T);
disp(yfit2);

load('30april')
Neural=net(B);
if(Neural>0.5 && Neural<=1)
    disp('NN=EDH');
elseif(Neural>1 && Neural<=2)
    disp('NN=ICH');
else
    disp('NN=SDH');
end