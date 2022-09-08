function [c1,c2,c3,cost,k1,k2,k3]=cluster_center(c1,c2,c3,P,d)

    for dd=1:5
    f=1;
    g=1;
    h=1;
    D1=0;
    D2=0;
    D3=0;
    cnw1=0;
    cnw2=0;
    cnw3=0;
        for e=1:size(P,2)
            d1=(P(:,e)' - c1(d,:))*(P(:,e)' - c1(d,:))';
            d2=(P(:,e)' - c2(d,:))*(P(:,e)' - c2(d,:))';
            d3=(P(:,e)' - c3(d,:))*(P(:,e)' - c3(d,:))';
        
            if ((d1<=d2)&&(d1<=d3))
                k1(d,f)=e;
                D1=D1+d1;
                cnw1=(cnw1 + P(:,e)');
                f=f+1;
            elseif ((d2<d1)&&(d2<=d3))
                k2(d,g)=e;
                D2=D2+d2;
                cnw2=(cnw2 + P(:,e)');
                g=g+1;
            elseif ((d3<d1)&&(d3<d2))
                k3(d,h)=e;
                D3=D3+d3;
                cnw3=(cnw3 + P(:,e)');
                h=h+1;
            end
        end
        sz1(d,:)=f-1;
        sz2(d,:)=g-1;
        sz3(d,:)=h-1;
        c1(d,:)=(cnw1/(f));
        c2(d,:)=(cnw2/(g));
        c3(d,:)=(cnw3/(h));
        cost(d,1)=D1+D2+D3;
 end
end