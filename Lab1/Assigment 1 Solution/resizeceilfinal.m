clc;
close all;
clear all;
I=imread('cells_scale.pgm');
[Ix,Iy]=size(I);
r=1.3;
k=r;
%[f1,f2]=[Ix*0.8,Iy*0.8]
I2 = uint8(zeros(round(Ix*k),round(Iy*k)));
for x=1:round (Ix*k)
    for y=1:round(Iy*k)
       Xs=x/r;
       Ys=y/r;
        a=Xs-floor(Xs);
        b=Ys-floor(Ys);
        %b= y-Ys;
        if Xs>=1 && Ys>=1 && Xs+1 <=  (Ix) && Ys+1 <=  (Iy)
        I2(x,y)=(1-a)*(1-b)*I(floor(Xs),floor(Ys))+(1-a)*b *I(floor(Xs),floor(Ys)+1)+(a)*(1-b)*I(floor(Xs)+1,floor(Ys))+(a)*(b)*I(floor(Xs)+1,floor(Ys)+1);
        end
    %end
    end
end

figure,subplot(1,2,1),imshow(I);
axis on;
subplot(1,2,2),imshow(I2);
axis on;