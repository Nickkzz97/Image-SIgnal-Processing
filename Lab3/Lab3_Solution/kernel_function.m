function [kernel,k_size]=kernelfunc(sd) 


 k_size=ceil(6*sd+1);
 
 if mod(k_size,2)==0
     k_size=k_size+1;
 end
 kernel = zeros(k_size,k_size);
 s=0;
 mid=floor((k_size+1)/2);
% 
 for i=1:k_size
     for j=1:k_size
         
        x=i-mid;
         y=j-mid;
         n=-1*(x*x+y*y)/(2*sd*sd);
         kernel(i,j)=exp(n)/(2*pi*sd*sd);
    s=s+kernel(i,j);
     end
    
 end
 
kernel=kernel/s;