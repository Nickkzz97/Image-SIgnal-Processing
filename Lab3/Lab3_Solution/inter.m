function [v]=inter(r,c,image)
u=r-floor(r);
t=c-floor(c);

[m,n,p]=size(image);
    if (r<1)||(c<1)||(r>m)||(c>n)
        v=0;
    else
        a1=ceil(r);
        a2=floor(r);
        b1=ceil(c);
        b2=floor(c);
        v=(1-t)*(1-u)*image(a2,b2,:) + t*(1-u)*image(a2,b1,:) + t*u*image(a1,b1,:) + (1-t)*(u)*image(a1,b2,:);  
    end
end
