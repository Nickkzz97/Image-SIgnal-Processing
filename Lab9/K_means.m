clc;
clear;
close all;
%I=imread('car.ppm');
I=imread('flower.png');
l = size(I,1)*size(I,2);
Iseq=zeros(3,l);

m=1;
for l1=1:size(I,1)
    for l2=1:size(I,2)
        Iseq(:,m)=I(l1,l2,:); %stores differnt R,G,B values of the image in different columns
        m=m+1;
    end
end
%given initial centers
c1=[255 0 0];
c2=[0 0 0];
c3=[255 255 255];

for d=1:5   % For Five iteration
    I1=zeros(1,1);
    I2=zeros(1,1);
    I3=zeros(1,1);
    clust1_pixel=1;
    clust2_pixel=1;
    clust3_pixel=1;
    clust1=0;
    clust2=0;
    clust3=0;
    for e=1:l
        d1=(Iseq(:,e)' - c1)*(Iseq(:,e)' - c1)';  %eucledian distance distance between different pixel to center
        d2=(Iseq(:,e)' - c2)*(Iseq(:,e)' - c2)';
        d3=(Iseq(:,e)' - c3)*(Iseq(:,e)' - c3)';
        
        if ((d1<=d2)&&(d1<=d3))  %finding out minimum distance
            I1(clust1_pixel)=e;             %image pixel belong to clust 1
            clust1=(clust1 + Iseq(:,e)');   %Adding all the RGB pixel values of clust 1 
            clust1_pixel=clust1_pixel+1;    %total no of pixel in clust 1
        elseif ((d2<d1)&&(d2<=d3))
            I2(clust2_pixel)=e;
            clust2=(clust2 + Iseq(:,e)');
            clust2_pixel=clust2_pixel+1;
        elseif ((d3<d1)&&(d3<d2))
            I3(clust3_pixel)=e;
            clust3=(clust3 + Iseq(:,e)');
            clust3_pixel=clust3_pixel+1;
            
        end
    end
    sz_clust1=size(I1);
    sz_clust2=size(I2);
    sz_clust3=size(I3);
    c1=(clust1/(sz_clust1(2)+1)); %finding color to be assigned to clusture 1
    c2=(clust2/(sz_clust2(2)+1));
    c3=(clust3/(sz_clust3(2)+1));
end
I_threshold_seq=zeros(size(Iseq));
%%Assigning all pixel of each clusture its corresponding color
%clust 1
for a=1:sz_clust1(2)%total no of pixel in I1
    I_threshold_seq(:,I1(a))=c1'; % assigning all pixel belonging to clusture 1 as RGB value of center of clusture 1
end
%clust 2
for b=1:sz_clust2(2)%total no of pixel in I2
    I_threshold_seq(:,I2(b))=c2'; % assigning all pixel belonging to clusture 1 as RGB value of center of clusture 2
end
%clust 3
for c=1:sz_clust3(2)%total no of pixel in I3
    I_threshold_seq(:,I3(c))=c3'; % assigning all pixel belonging to clusture 1 as RGB value of center of clusture 3
end


%%forming the final thresholded image
I_threshold=zeros(size(I));
q=1;
for i=1:size(I,1)
    for j=1:size(I,2)
        I_threshold(i,j,:)=I_threshold_seq(:,q); %Forming image with founded clusture
        q=q+1;
    end
end

figure(1)

subplot(1,2,1),imshow(I);subplot(1,2,2),imshow(uint8(I_threshold));


