function [w b erms epoc] = adalaine1(in,out,n)

epoc = 0;
pesos = rand(1,size(in,2));
e = 1;
maxepoc = 300000;
erms = zeros(1,maxepoc);
while (abs(e) > 0.0004 && epoc < maxepoc && e ~= Inf)
    u = in*pesos';
    y = purelin(u);
    e1 = out - y;
    e = sqrt(mean(e1.^2));
    epoc = epoc + 1;
    erms(epoc) = e;
    pesos = pesos + n*(in'*e1)';
end
w = pesos;
b = 0;
end