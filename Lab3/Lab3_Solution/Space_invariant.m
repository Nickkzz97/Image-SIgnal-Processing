clc;
close all;
clear all;
I=imread('Globe.pgm');
figure,imshow(I)
I=double(I);
[r1 c1]=size(I);
I_blur=zeros(size(I));
for i=1:r1
    for j=1:c1
        sigma(i,j)= A* exp(-((i-1-128)^2 + (j-1-128)^2)/(B));
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
        img_zeropad(i,j)=inter((i-((6*x)/2)+1),(j-((6*x)/2)+1),I);
    end
end
figure,imshow(img_zeropad)
img_zeropad=double(img_zeropad);
Blurred_img=zeros(size(img_zeropad),'double');
for i=(6*(x/2))+1 : P-(6*(x/2))
    for j=(6*(x/2))+1 : Q-(6*(x/2))
        sig = sigma(i-(6*(x/2)),j-(6*(x/2)));
[kernel,k_size]=kernel_function(sig);
AA=kernel*img_zeropad(i,j);
for ii=1:k_size
           for jj=1:k_size
               Blurred_img(i-6-((k_size-1)/2)+ii,j-6-((k_size-1)/2)+jj)=AA(ii,jj)+Blurred_img(i-6-((k_size-1)/2)+ii,j-6-((k_size-1)/2)+jj);
          
           
           end
       end
    end
end


figure,imshow(uint8(Blurred_img))
for  i=1:size(I,1)
    for j=1:size(I,2)
    I_blur(i,j)=Blurred_img(i,j);
    end
end
figure,imshow(uint8(I_blur))