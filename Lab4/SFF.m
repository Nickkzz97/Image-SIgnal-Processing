clc;
clear all; 
close all;

f=load("stack.mat");
I=eval(['f.frame',sprintf('%.3d',1)]);

step=1;  
window=input("Enter the size of the window(eg,3 or 5 ):");
deld=50.50;

ML_matrix=zeros(size(I,1),size(I,2),100);
FM_matrix=zeros(size(I,1),size(I,2),100);
depth_map=zeros(size(I,1),size(I,2));

% STEP_1: MODIFIED LAPLACIAN MATRIX

for n=1:100
    I=eval(['f.frame',sprintf('%.3d',n)]);
    ML_matrix(:,:,n)=modified_laplacian(I,step);
end

% STEP_2: SUM MODIFIED LAPLACIAN MATRIX

for n=1:100
    for i=1:size(FM_matrix,1)
        for j=1:size(FM_matrix,2)

            FM_matrix(i,j,n)=summodified_laplacian(ML_matrix(:,:,n),window,i,j);
            
        end
    end
end
for i=1:100
    for j=1:100
      focus_arr=squeeze(FM_matrix(i,j,:));
      depth_map(i,j)=Gaussian_interpol(focus_arr,deld,100);
    end
end
mesh(depth_map);

%%The depth is maximum at a point after which it again start to decrease