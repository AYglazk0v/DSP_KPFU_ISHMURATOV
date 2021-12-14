function y = myFilter(a, b, x)
na=length(a);
nb=length(b);
y = zeros(1,length(x));
for n=max(na,nb):length(x);
    y(n)=b(1)*x(n);
    NB=0; NA=0;
    for k=2:nb
        NB=NB+b(k)*x(n-k+1);
    end
    for k=2:na
        NA=NA+a(k)*y(n-k+1);
    end    
    y(n)=y(n)+NB-NA;
     y(n)=y(n)*a(1);
end
end

x = sin(t/2) + sin(3*t);
y = filter(a, b, x);
z=myFilter(b,a,x);
 

