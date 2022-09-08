clc
clear all;
close all
img=imread('pisa_rotate.pgm');

[rowsi,colsi]= size(img); 

angle=4;

rads=2*pi*angle/360;  


C=uint8(zeros([rowsi colsi ]));

% center 
xo=ceil(rowsi/2);                                                            
yo=ceil(colsi/2);

midx=ceil((size(C,1))/2);
midy=ceil((size(C,2))/2);

% calculate corresponding coordinates of pixel of A 
A=img;
for i=1:size(C,1)
    for j=1:size(C,2)                                                       

         x= (i-midx)*cos(rads)+(j-midy)*sin(rads);                                       
         y= -(i-midx)*sin(rads)+(j-midy)*cos(rads);   
         a=x-floor(x);
         b=y-floor(y);
         
         x=round(x)+xo;
         y=round(y)+yo;

         if (x>=1 && y>=1 && x+1<=size(img,1) &&  y+1<=size(img,2) ) 
             C(i,j)= ((1-a)*(1-b)*A(floor(x),floor(y)))+(a*(1-b)*A(floor(x),floor(y+1)))+ ...
             (b*(1-a)*A(floor(x+1),floor(y)))+(a*b*A(floor(x+1),floor(y+1))); 
         end
%           

    end
end
figure,subplot(1,2,1),imshow(img);
subplot(1,2,2),imshow(C);

