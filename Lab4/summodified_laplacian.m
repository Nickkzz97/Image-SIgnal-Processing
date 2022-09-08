function[f]=summodified_laplacian(ML,window,i,j)

f=0;

for x=i-window:i+window
    for y=j-window:j+window
         
        if(x>0 & x<=size(ML,1) & y>0 & y<=size(ML,2))
            
             
             f=f+ML(x,y);
        end
    end
end
end