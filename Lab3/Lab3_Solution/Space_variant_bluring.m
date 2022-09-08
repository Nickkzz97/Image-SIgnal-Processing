% clc;
% close all;
% clear all;
I=imread('Nautilus.pgm');
figure,imshow(I),title('original image')
I=double(I);
[r1 c1]=size(I);
%%Space Inavriant Blurring
I_blur_inv=zeros(size(I));

sigma=1.6;
x=sigma;
img_zeropad=zeros(((r1)+ceil(6*(x))),((c1)+ceil(6*(x))),'uint8');
  
 [P,Q]=size(img_zeropad);

%%interpolating the values for zero padding
for i=1:P
    for j=1:Q
        img_zeropad(i,j)=inter((i-((6*x)/2)),(j-((6*x)/2)),I);
    end
end
figure,imshow(img_zeropad)
img_zeropad=double(img_zeropad);
Inv_Blurred_img=zeros(size(img_zeropad),'double');
for i=((6*(x/2))+1) : P-(6*(x/2))
    for j=((6*(x/2))+1) : Q-(6*(x/2))
     [kernel,k_size]=kernel_function(sigma);
     AA=kernel*img_zeropad(i,j);
for ii=1:k_size
           for jj=1:k_size
               Inv_Blurred_img(i-((k_size-1)/2)-1+ii,j-((k_size-1)/2)+jj-1)=AA(ii,jj)+Inv_Blurred_img(i-((k_size-1)/2)+ii-1,j-((k_size-1)/2)+jj-1);
          
           
           end
       end
    end
end
for  i=1:size(I,1)
    for j=1:size(I,2)
    I_blur_inv(i,j)=Inv_Blurred_img(i+(6*x/2),j+(6*x/2));
    end
end
figure(2),imshow(uint8(I_blur_inv)),title('Space Invariant Blurring')