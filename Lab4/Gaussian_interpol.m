function[depth]=Gaussian_interpol(f,deld,s)

[fmax,imax] = max(f);  %max focus value && value of index @max focus


imaxl=imax-1;
imaxr=imax+1;

if(imaxl<=0)
    imaxl=imax;
end

if(imaxr>s)
    imaxr=imax;
end
fmaxl=f(imaxl);
fmaxr=f(imaxr);

dmax=imax*deld;
dmaxl=imaxl*deld;
dmaxr=imaxr*deld;

n1=(log(fmax)-log(fmaxr))*(dmax*dmax-dmaxl*dmaxl);
n2=(log(fmax)-log(fmaxl))*(dmax*dmax-dmaxr*dmaxr);
n=n1-n2;

d1=log(fmax)-log(fmaxl);
d2=log(fmax)-log(fmaxr);
d=2*deld*(d1+d2);

depth=n/d;
end