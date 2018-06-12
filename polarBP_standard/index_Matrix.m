function A = index_Matrix(N)
x = 1:N;
n = log2(N);
M = zeros(N-1, n);
for k = 0:n-1
    for i = 0:2^(k+1):N
        if (2^k+i) < N
            M(i+1:i+2^k,n-k) = x((1:2^k) + i);
        end
    end
end
A = reshape(M(M>0), [N/2,n]);
        
                