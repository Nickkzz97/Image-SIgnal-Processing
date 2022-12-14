function [H,V]=homo_mat(p,P,q,Q,r,R,s,S)

A=[ -p(1,1), -p(1,2), -1   , 0     ,0      , 0      ,p(1,1)*P(1,1), p(1,2)*P(1,1) , P(1,1);
    0     , 0     , 0   , -p(1,1), -p(1,2), -1      , p(1,1)*P(1,2), p(1,2)*P(1,2) , P(1,2);
    -q(1,1), -q(1,2), -1   , 0     ,0      , 0      ,q(1,1)*Q(1,1), q(1,2)*Q(1,1) , Q(1,1);
    0     , 0     , 0   , -q(1,1), -q(1,2), -1      , q(1,1)*Q(1,2), q(1,2)*Q(1,2) , Q(1,2);
    -r(1,1), -r(1,2), -1   , 0     ,0      , 0      ,r(1,1)*R(1,1), r(1,2)*R(1,1) , R(1,1);
    0     , 0     , 0   ,-r(1,1), -r(1,2), -1      , r(1,1)*R(1,2), r(1,2)*R(1,2) , R(1,2);
    -s(1,1), -s(1,2), -1   , 0     ,0      , 0      ,s(1,1)*S(1,1), s(1,2)*S(1,1) , S(1,1);
    0     , 0     , 0   , -s(1,1), -s(1,2), -1      , s(1,1)*S(1,2), s(1,2)*S(1,2) , S(1,2);];

[U,S,V] = svd(A);
size(U);
size(S);
size(V);
H=V(:,end);
H=reshape(H,3,3);
H;
H =H/ H(3,3);
H=H';
end

