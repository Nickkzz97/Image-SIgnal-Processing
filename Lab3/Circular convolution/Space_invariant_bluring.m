I=imread('Nautilus.pgm');
figure(1),imshow(I,[0,255])


std_dev=input('Enter the value of Standard Deviation:');

%K_size=ceil((6*std_dev)+1);

[kernel,sum,k_size]=kernel_function(std_dev);

I_blur = zeros(size(I,1),size(I,2));

for i=1:size(I_blur,1)
    for j=1:size(I_blur,2)
        
        
        I_blur(i,j)=convolution(I,kernel,i,j);
       
    end
end

figure(2), imshow(I_blur,[0,255])
title(strcat('kernelsize=',int2str(k_size)));