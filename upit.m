function [b] = upit(a,n)
[s,t] = size(a);
%s
x = s*(n-1)+s;
b = zeros( x,1);

[v,t] = size(b);
%v
ind = 0;
for i = 1:s
    b(i+ind) = a(i);
    ind = ind + (n-1);
end



