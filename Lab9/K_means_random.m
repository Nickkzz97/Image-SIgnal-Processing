clc;
clear all;
close all;
%I=imread('car.ppm');
I=imread('flower.png');
l = size(I,1)*size(I,2);
Iseq=zeros(3,l);
figure(1),subplot(1,3,1),imshow(I),title('original image')
m=1;
for l1=1:size(I,1)
    for l2=1:size(I,2)
        Iseq(:,m)=I(l1,l2,:); %stores differnt R,G,B values of the image in different columns
        m=m+1;
    end
end
c1=zeros(30,3);      % %vector of center for clusture
c2=zeros(30,3);
c3=zeros(30,3);
k1=zeros(30,1);
k2=zeros(30,1);
k3=zeros(30,1);
sz1=zeros(30,1);           
sz2=zeros(30,1);           
sz3=zeros(30,1);
cost=zeros(30,1);
for d=1:30          %kmeans clusturing with 30 different initialisations
    
    c1(d,:)=randi([0,255],1,3); % 3 random clusture center initialisation
    c2(d,:)=randi([0,255],1,3);
    c3(d,:)=randi([0,255],1,3);
    for dd=1:5
    D1=0;
    D2=0;
    D3=0;
    clust1_pixel=1;
    clust2_pixel=1;
    clust3_pixel=1;
    clust1=0;
    clust2=0;
    clust3=0;
        for e=1:l
            d1=(Iseq(:,e)' - c1(d,:))*(Iseq(:,e)' - c1(d,:))';     %eucledian distance distance between different pixel to center
            d2=(Iseq(:,e)' - c2(d,:))*(Iseq(:,e)' - c2(d,:))';
            d3=(Iseq(:,e)' - c3(d,:))*(Iseq(:,e)' - c3(d,:))';
        
            if ((d1<=d2)&&(d1<=d3))
                k1(d,clust1_pixel)=e;
                D1=D1+d1;
                clust1=(clust1 + Iseq(:,e)');
                clust1_pixel=clust1_pixel+1;         %no of pixels belonging to this group 
            elseif ((d2<d1)&&(d2<=d3))
                k2(d,clust2_pixel)=e;
                D2=D2+d2;
                clust2=(clust2 + Iseq(:,e)');
                clust2_pixel=clust2_pixel+1;
            elseif ((d3<d1)&&(d3<d2))
                k3(d,clust3_pixel)=e;
                D3=D3+d3;
                clust3=(clust3 + Iseq(:,e)');
                clust3_pixel=clust3_pixel+1;
            end
        end
        sz1(d,:)=clust1_pixel-1;
        sz2(d,:)=clust2_pixel-1;
        sz3(d,:)=clust3_pixel-1;
        c1(d,:)=(clust1/(clust1_pixel));    %new clusture center
        c2(d,:)=(clust2/(clust2_pixel));
        c3(d,:)=(clust3/(clust3_pixel));
        cost(d,1)=D1+D2+D3;   % %total cost for each initialisation of clusture center
        
    end
    
end
[max,idh]=sort(cost,'descend');  %%take clusture with macimum cost function
[min,id1]=sort(cost);              %take clusture with minimum cost function
Iseq2=zeros(3,l);
for k=1:sz1(idh(1),1)%size of clusture with maximum cost function for color 1
    
    Iseq2(:,k1(idh(1),k))=(c1(idh(1),:))';   %assigning color of clusture center to all the pixels having max cost 
end

for l=1:sz2(idh(1),1)       %size of clusture with maximum cost function for color 2
    Iseq2(:,k2(idh(1),l))=(c2(idh(1),:))';
end

for m=1:sz3(idh(1),1)  %size of clusture with maximum cost function for color 3
    Iseq2(:,k3(idh(1),m))=(c3(idh(1),:))';
end

I2=zeros(size(I));
p=1;
for ii=1:200
    for jj=1:175
        I2(ii,jj,:)=Iseq2(:,p);
        p=p+1;
    end
end

figure(1)
subplot(1,3,2),imshow(uint8(I2)),title('K_means clusturing with max cost');
%%similarly for minimum cost
Iseq3=zeros(3,l);

for k=1:sz1(id1(1),1)
    
    Iseq3(:,k1(id1(1),k))=(c1(id1(1),:))';
end

for l=1:sz2(id1(1),1)
    Iseq3(:,k2(id1(1),l))=(c2(id1(1),:))';
end

for m=1:sz3(id1(1),1)
    Iseq3(:,k3(id1(1),m))=(c3(id1(1),:))';
end

I3=zeros(size(I));
p=1;
for ii=1:size(I,1)
    for jj=1:size(I,2)
        I3(ii,jj,:)=Iseq3(:,p);
        p=p+1;
    end
end

figure(1)

subplot(1,3,3),imshow(uint8(I3)),title('K_means clusturing with min cost');
