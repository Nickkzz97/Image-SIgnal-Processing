clc;
close all;
clear all;
I=imread('Nautilus.pgm');
figure,imshow(I)
I=double(I);
[r1 c1]=size(I);

I_blur=zeros(size(I));

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
Blurred_img=zeros(size(img_zeropad),'double');
for i=(6*(x/2))+1 : P-(6*(x/2))
    for j=(6*(x/2))+1 : Q-(6*(x/2))
     [kernel,k_size]=kernel_function(sigma);
     AA=kernel*img_zeropad(i,j);
for ii=1:k_size
           for jj=1:k_size
               Blurred_img(i-((k_size-1)/2)-1+ii,j-((k_size-1)/2)+jj-1)=AA(ii,jj)+Blurred_img(i-((k_size-1)/2)+ii-1,j-((k_size-1)/2)+jj-1);
          
           
           end
       end
    end
end
for  i=1:size(I,1)
    for j=1:size(I,2)
    I_blur_inv(i,j)=Blurred_img(i+(6*x/2),j+(6*x/2));
    end
end
figure,subplot(1,2,1),imshow(uint8(I_blur_inv)),title('Space_Invariant_Blurring');
I_var_blur=zeros(size(I));
A=2;
B=(2*(128^2))/(log(200));

for i=1:r1
    for j=1:c1
        sigma(i,j)= 1;
    end
end
[maximum,i] =max(max(sigma(:,:)));
minimum=min(min(sigma(:,:)));
x=maximum; 
img_zeropad=zeros(((r1)+6*(x)),((c1)+6*(x)),'uint8');
  
 [P,Q]=size(img_zeropad);

%%interpolating the values for zero padding
for i=1:P
    for j=1:Q
        img_zeropad(i,j)=inter((i-((6*x)/2)),(j-((6*x)/2)),I);
    end
end
img_zeropad=double(img_zeropad);
Var_Blurred_img=zeros(size(img_zeropad),'double');
for i=(6*(x/2))+1 : P-(6*(x/2))
    for j=(6*(x/2))+1 : Q-(6*(x/2))
        sig = sigma(i-(6*(x/2)),j-(6*(x/2)));
        
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
subplot(1,2,2),imshow(uint8(I_var_blur)),title('Space_variant_Blurring');
Sub_img=zeros(size(I));
Sub_img=I_var_blur-I_blur_inv;
imshow(Sub_img);