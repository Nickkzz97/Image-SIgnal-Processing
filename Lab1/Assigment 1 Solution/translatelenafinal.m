clc;
close all;
clear all;
%I=imread('lena_translate.pgm');
I=imread('lena_translate.pgm');
size(I)
tx=(0.1)
ty=(0.1)
I2 = uint8(zeros(size(I)));
[X,Y]=size(I)
i=1;
for x=1:X
    for y=1:Y
        i=i+1
        a=tx-floor(tx);
        b=ty-floor(ty);
        Xs=x-floor(tx);
        Ys=y-floor(ty);
        %b= y-Ys;
        if Xs>=1 && Ys>=1 && Xs <= X && Ys <= Y
        I2(x,y)=(1-a)*(1-b)*I(Xs,Ys)+(1-a)*b *I(Xs,Ys+1)+(a)*(1-b)*I(Xs+1,Ys)+(a)*(b)*I(Xs+1,Ys+1);%Bilinear Interpolation
        end
    end
end

figure,subplot(1,2,1),imshow(I);
subplot(1,2,2),imshow(I2);
axis on;