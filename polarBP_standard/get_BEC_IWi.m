function IWi=get_BEC_IWi(N)
IWi=zeros(N,1);
IWi(1) = 1-0.32;
I_tmp=zeros(N,1);
m=1;
while(m<=N/2)
    for k=1:m
        I_tmp(k)=IWi(k)*IWi(k);
        I_tmp(k+m)=2*IWi(k)-IWi(k)*IWi(k);
    end
    IWi=I_tmp;
    m=m*2;
end
IWi=IWi(bitrevorder(1:N));
end