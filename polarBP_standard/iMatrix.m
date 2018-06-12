function Matrix = iMatrix(N)
n = log2(N);
Matrix = zeros(n,N);
for i = 1:N
    Matrix(1, i)  = i;
end
Nv=N;
for i = 2:n
    for j = 1:Nv:N
        for k = j:2:j + Nv -1
            s = k-j;
            Matrix(i, j+s/2) = Matrix(1, k);
            Matrix(i, j+s/2+Nv/2) = Matrix(1, k+1);
        end
        
    end
    Nv = Nv/2;
end
end