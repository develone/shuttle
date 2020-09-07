function [b] = upit(a,n)
[s,t] = size(a);
%s
x = floor(s/n);
b = zeros(x,1);
% [v,t] = size(b);
% %v
ind = 1;
for i = 1:s
    
    if(i < x)
        b(i) = a(ind);
    end
    ind = ind + n;
end
