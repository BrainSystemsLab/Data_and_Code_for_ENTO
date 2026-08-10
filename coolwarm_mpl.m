function cmap = coolwarm_mpl(N)

c1=[59 76 192]/255; cW=[1 1 1]; c2=[180 4 38]/255;
t=linspace(0,1,N)'; cmap=zeros(N,3);
for k=1:N
    if t(k)<=0.5, a=2*t(k); cmap(k,:)=(1-a)*c1 + a*cW;
    else,         a=2*(t(k)-0.5); cmap(k,:)=(1-a)*cW + a*c2;
    end
end
end