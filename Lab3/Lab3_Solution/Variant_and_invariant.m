clc;
close all;
clear all;
I=imread('Nautilus.pgm');
figure,imshow(I),title('original image')
I=double(I);
[r1 c1]=size(I);
%%Space Inavriant Blurring
I_blur_inv=zeros(size(I));

sigma=1;
x=sigma;
img_zeropad=zeros(((r1)+6*(x)),((c1)+6*(x)),'uint8');
  
 [P,Q]=size(img_zeropad);

%%interpolating the values for zero padding
for i=1:P
    for j=1:Q
        img_zeropad(i,j)=inter((i-((6*x)/2)+1),(j-((6*x)/2)+1),I);
    end
end
img_zeropad=double(img_zeropad);
Inv_Blurred_img=zeros(size(img_zeropad),'double');
for i=(6*(x/2))+1 : P-(6*(x/2))
    for j=(6*(x/2))+1 : Q-(6*(x/2))
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
figure(2),subplot(1,2,1),imshow(uint8(I_blur_inv)),title('Space Invariant Blurring')

%%Space Variant Blurring
I_var_blur=zeros(size(I));


for i=1:r1
    for j=1:c1
        sigma2(i,j)= 1;
    end
end
[maximum,i] =max(max(sigma2(:,:)));
minimum=min(min(sigma2(:,:)));
x=maximum; 
img_zeropad=zeros(((r1)+6*(x)),((c1)+6*(x)),'uint8');
  
 [P,Q]=size(img_zeropad);

%%interpolating the values for zero padding
for i=1:P
    for j=1:Q
        img_zeropad(i,j)=inter((i-((6*x)/2)+1),(j-((6*x)/2)+1),I);
    end
end
img_zeropad=double(img_zeropad);
Var_Blurred_img=zeros(size(img_zeropad),'double');
for i=(6*(x/2))+1 : P-(6*(x/2))
    for j=(6*(x/2))+1 : Q-(6*(x/2))
        sig = sigma2(i-(6*(x/2)),j-(6*(x/2)));
        [kernel,k_size]=kernel_function(sig);
           AA=kernel*img_zeropad(i,j);
for ii=1:k_size
           for jj=1:k_size
               Var_Blurred_img(i-((k_size-1)/2)+ii-1,j-((k_size-1)/2)+jj-1)=AA(ii,jj)+Var_Blurred_img(i-((k_size-1)/2)+ii-1,j-((k_size-1)/2)+jj-1);
          
           
           end
       end
    end
end
for  i=1:size(I,1)
    for j=1:size(I,2)
    I_var_blur(i,j)=Var_Blurred_img(i+(6*x/2),j+(6*x/2));
    end
end
figure(2),subplot(1,2,2),imshow(uint8(I_var_blur)),title('Space variant Blurring')
%%Comparision Between Space variant and Space invariant

Sub_img=zeros(size(I));
Sub_img=I_var_blur-I_blur_inv;
figure,imshow(uint8(Sub_img))