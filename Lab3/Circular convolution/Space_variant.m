clc;
close all;
clear all;
I=imread('Globe.pgm');
figure,imshow(I)
%I=double(I);
[r1 c1]=size(I);
A=2;
B=(2*(128^2))/(log(200));
sigma=zeros(r1,c1);
for i=1:r1
    for j=1:c1
        sigma(i,j)= A* exp(-((i-1-128)^2 + (j-1-128)^2)/(B));
    end
end
[maximum,i] =max(max(sigma(:,:)));
minimum=min(min(sigma(:,:)));
x=maximum;

  I_blur=zeros(r1,c1,'uint8');

for i=1:size(I_blur,1)
    for j=1:size(I_blur,2)
        sig = sigma(i,j);
        [kernel,sum,k_size]=kernel_function(sig);
        I_blur(i,j)=convolution(I,kernel,i,j);
       
    end
end

figure(2), imshow(I_blur,[0,255])
