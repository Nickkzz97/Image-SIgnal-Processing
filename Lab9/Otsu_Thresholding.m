clc;
clear all;
close all;
I1=imread('palmleaf1.pgm');
I2=imread('palmleaf2.pgm');
% IB1=zeros(size(I1));
% IB2=zeros(size(I2));
figure(1),subplot(2,2,1),imshow(I1)
figure(2),subplot(2,2,1),imshow(I2)
H1=imhist(I1); %%Histogram of image 1
figure(1),subplot(2,2,3),imhist(I1);
H2=imhist(I2); %%Histogram of image 2
figure(2),subplot(2,2,3),imhist(I2);

MuI11=zeros(256,1);
MuI12=zeros(256,1);
MuI21=zeros(256,1);
MuI21=zeros(256,1);

sigbI1=zeros(256,1);
sigbI2=zeros(256,1);

for i=1:255
    h11=H1(1:i);        %taking i as threshold limit
    p11=sum(h11);       %total number of pixel betwwn o and i(threshold value)
    h12=H1(i+1:256);    %second part of image histogram
    p12=sum(h12);       %total no of pixel values beyond threshold value
    h21=H2(1:i);        %similarly for image 2
    p21=sum(h21);       
    h22=H2(i+1:256);
    p22=sum(h22);
    MuI11(i)= dot(h11',0:i-1)/p11;  %mean of part 1 of image 1
    MuI21(i)= dot(h21',0:i-1)/p21;  %,ean of part 2 og image 1
   % similarly calculating mean for image 2
    MuI12(i)= dot(h12',i:255)/p12;
    MuI22(i)= dot(h22',i:255)/p22;
    
    MuI1t= dot(H1',0:255)/sum(H1); % total mean of image 1
    MuI2t= dot(H2',0:255)/sum(H2);  %total mean of image 2
    
    
    
    sigbI1(i)= (((MuI11(i)-MuI1t)^2) *(p11/sum(H1))) + (((MuI12(i)-MuI1t)^2) *(p12/sum(H1)));  %Between class variance_img1
    sigbI2(i)= (((MuI21(i)-MuI2t)^2) *(p21/sum(H2))) + (((MuI22(i)-MuI2t)^2) *(p22/sum(H2))); %Between class variance_img2
    h11=[];
    h12=[];
    h21=[];
    h22=[];
    
end
[sigB1,i1]=max(sigbI1) %position of maximum between class variance of image 1
[sigB2,i2]=max(sigbI2) %position of maximum between class variance of image 2


for i=1:size(I1,1)
    for j=1:size(I1,2)
        if (I1(i,j)<=i1(1))
            I1(i,j)=0;
        else
            I1(i,j)=255;
        end
    end
end
figure(1),subplot(2,2,2),imshow(uint8(I1));
for i=1:size(I2,1)
    for j=1:size(I2,2)
        if (I2(i,j)<=i2(1))
            I2(i,j)=0;
        else
            I2(i,j)=255;
        end
    end
end
figure(2),subplot(2,2,2),imshow(uint8(I2));

%%In image 1 the illumination is uniform so global thresholding worked
%%properly.But in image 2 their is gradient in illumination so the global
%%threhold didn't work properly.