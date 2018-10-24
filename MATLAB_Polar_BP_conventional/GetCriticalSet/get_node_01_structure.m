function [rate0_structure, rate1_structure] = get_node_01_structure(frozen_bits)

frozen_bits = mod(frozen_bits + 1, 2);
N = length(frozen_bits);
binary_tree = -ones(1 + log2(N), N);
node_index = -ones(1 + log2(N), N);
binary_tree(1 + log2(N), :) = frozen_bits;
cnt_tree = 2;

for i = log2(N):-1:1
    for j = 1:N/cnt_tree
        binary_tree(i, j) = binary_tree(i + 1, 2*j - 1) + binary_tree(i + 1, 2*j);
    end
    cnt_tree = cnt_tree + 1;
end

cnt_index_layer = 1;
cnt_index_plus = 1;
for i = 1:log2(N) + 1
    for j = 1:cnt_index_layer
        node_index(i, j) = cnt_index_plus;
        cnt_index_plus = cnt_index_plus + 1;
    end
    cnt_index_layer = cnt_index_layer * 2;
end


cnt_tree = 1;
cnt_rate0 = 1;
cnt_rate1 = 1;

for i = 1:log2(N)
    
    for j = 1:cnt_tree
        
        if binary_tree(i, j) == 0
            
            kaishi = node_index(i, j);
            jieshu = node_index(i, j);
            
            for k = 1:log2(N) - i + 1
                kaishi = kaishi * 2;
                jieshu = jieshu * 2 + 1;
            end
            
            changdu = jieshu - kaishi + 1;
            kaishi = kaishi - N + 1;
            rate0_structure(cnt_rate0, 1) = kaishi;
            rate0_structure(cnt_rate0, 2) = changdu;
            cnt_rate0 = cnt_rate0 + 1;
            
        else
            
            if binary_tree(i, j) == 2^(log2(N) + 1 - i)
                
                kaishi = node_index(i, j);
                jieshu = node_index(i, j);
                
                for k = 1:log2(N) - i + 1
                    kaishi = kaishi * 2;
                    jieshu = jieshu * 2 + 1;
                end
                
                changdu = jieshu - kaishi + 1;
                kaishi = kaishi - N + 1;
                rate1_structure(cnt_rate1, 1) = kaishi;
                rate1_structure(cnt_rate1, 2) = changdu;
                cnt_rate1 = cnt_rate1 + 1;
            end
            
        end
        
    end
    cnt_tree = cnt_tree * 2;
end
end