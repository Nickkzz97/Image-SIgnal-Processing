clc;
clear all;
close all;
I1=imread('IMG1.pgm');
I2=imread('IMG2.pgm');
figure, imshow(I1,[0,255])
figure,imshow(I2,[0,255])


[m,n] = size(I2);

A=[125 30 1 0; 30 -125  0 1; 373 158 1 0; 158 -373 0 1];
y=[249 94 400 329 ];
y=y';
x=inv(A)*y;

tx=x(3);
ty=x(4);
R = [x(1) , x(2); -x(2), x(1)];
thita= acos(x(1));
T = [-x(3);x(4)];

M =[ R T; 0 0 1]
B=uint8(zeros(size(I1)));
for i=1:size(I2,1)
    for j= 1:size(I2,2)
     xx=((i)*x(1)-(j)*x(2))+ty;
        yy=((i)*x(2)+(j)*x(1))+tx;
         a=xx-floor(xx);
        b=yy-floor(yy);
         if (floor(xx)>=1 && floor(yy)>=1 &&  floor(xx)+1<=size(I2,1) && floor(yy)+1<=size(I2,2))
            B(i,j)=(1-a)*(1-b)*I2(floor(xx),floor(yy))+a*(1-b)*I2(floor(xx),floor(yy)+1)+b*(1-a)*I2(floor(xx)+1,floor(yy))+a*b*I2(floor(xx)+1,floor(yy)+1);  
           
        end
    end
end
figure,imshow(B)
[P,Q]=size(I1);
I=uint8(zeros(size(I1)));

for i=1:P
    for j=1:Q

           I(i,j)=I(i,j)+B(i,j);
        
    end
end
figure,imshow(I);
figure,imshow(imsubtract(I,I1))    
