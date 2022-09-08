function [output]=convolution(I1,kernel,i,j) 

output=0;

for m=1:size(kernel,1)
    for n=1:size(kernel,2)
        
        if (i-m)<=0
            a=(i-m)+size(I1,1);
        else
            a=i-m;
        end
            
        if (j-n)<=0
            b=(j-n)+size(I1,2);
        else
            b=j-n;
        end
        
        output=output+kernel(m,n)*I1(a,b);
        
        
      
    end
end
end


