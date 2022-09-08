clc;
close all;
clear all;
I=imread('Globe.pgm');
figure,imshow(I)
I1=double(I);
[r1 c1]=size(I);
I_blur=zeros(size(I1));

sigma=input('Enter the value of Standard Deviation:');
x=sigma; 
k1_size=ceil(6*x+1);
if mod(k1_size,2)==0
     k1_size=k_size+1;
 end
img_zeropad=zeros(((r1)+(k1_size-1)),((c1)+(k1_size-1)));
  
 [P,Q]=size(img_zeropad);

%%interpolating the values for zero padding
for i=1:P
    for j=1:Q
        img_zeropad(i,j)=inter((i-((6*x)/2)),(j-((6*x)/2)),I1);
        img_zeropad=uint8(img_zeropad);
    end
end
figure,imshow(img_zeropad)
img_zeropad=double(img_zeropad);
Blurred_img=zeros(size(img_zeropad),'double');
for i=ceil(6*(x/2))+1 : P-ceil(6*(x/2))
    for j=ceil(6*(x/2))+1 : Q- ceil(6*(x/2))
        
[kernel,k_size]=kernel_function(sigma);
AA=kernel*img_zeropad(i,j);
for ii=1:k_size
           for jj=1:k_size
              Blurred_img(i-(floor(k_size/2)+1)+ii,j-(floor(k_size/2)+1)+jj)=AA(ii,jj)+  Blurred_img(i-(floor(k_size/2)+1)+ii,j-(floor(k_size/2)+1)+jj);
          
           
           end
       end
    end
end


figure,imshow(uint8(Blurred_img))
for  i=1:size(I,1)
    for j=1:size(I,1)
    I_blur(i,j)=Blurred_img((i+ceil(6*x/2)),j+ceil(6*x/2));
    
    end
end
figure,imshow(uint8(I_blur))