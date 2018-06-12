function info_esti = BP_Decoder_LLR(info_bits, frozen_bits, llr, max_iter, M)
N = length(frozen_bits);
n = log2(N);
R = zeros(N, n+1);
L = zeros(N, n+1);
%≥ı ºªØR
for i = 1:N
    if frozen_bits(i) == 1
        R(i, 1) = realmax;
    end
end

L(:, n+1) = llr;

for iter = 1:max_iter

    for j = n:-1:1
        for i = 1:N/2
            L(2*i-1,j) = f(L(M(i,j),j+1), L(M(i,j)+N/2^j,j+1) + R(2*i,j));
            L(2*i,j) = L(M(i,j)+N/2^j,j+1) + f(L(M(i,j),j+1), R(2*i-1, j));
        end
    end

    for j = 1:n
        for i = 1:N/2
            R(M(i, j),j+1) = f(R(2*i,j) + L(M(i,j)+N/2^j,j+1), R(2*i-1,j));
            R(M(i,j)+N/2^j,j+1) = f(R(2*i-1, j), L(M(i,j), j+1)) + R(2*i,j);
        end
    end
    
end

u_hat = L(:,1) < 0;
info_esti = u_hat(info_bits);
end