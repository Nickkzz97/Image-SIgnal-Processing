function[ML]=modified_laplacian(I1,step)
ML=zeros(size(I1));

for i=1:size(I1,1)
    for j=1:size(I1,2)
        
        x0=i-step;
        x1=i+step;
        y0=j-step;
        y1=j+step;
        
        if(x0<=0)
            x0=x0+size(I1,1);
        end
        
        if(x1>size(I1,1))
            x1=x1-size(I1,1);
        end
        
        if(y0<=0)
            y0=y0+size(I1,2);
        end
        
        if(y1>size(I1,2))
            y1=y1-size(I1,2);
        end
        
        
        ML(i,j)=abs(2*I1(i,j)-I1(x0,j)-I1(x1,j))+abs(2*I1(i,j)-I1(i,y0)-I1(i,y1));
        
    end
end
end
