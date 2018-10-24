function cs = get_cs(rate1_structure, frozen_bits, seg_index)
N = length(frozen_bits);
cs_part1 = rate1_structure(: , 1);
cnt1 = 1;
cs_part2 = zeros(N, 1);
cnt2 = 1;
for i = 2 : length(frozen_bits) - 1
    if i == cs_part1(cnt1)
        cnt1 = cnt1 + 1;
        
        if cnt1 == (length(cs_part1) + 1)
            cnt1 = 1;
        end
        
        continue;
    else
        if (mod(i, 2) == 1) &&(frozen_bits(i) == 0) && (frozen_bits(i + 1) == 1)
            cs_part2(cnt2) = i;
            cnt2 = cnt2 + 1;
        else
            if (mod(i, 2) == 0) &&(frozen_bits(i) == 0) && (frozen_bits(i - 1) == 1)
                cs_part2(cnt2) = i;
                cnt2 = cnt2 + 1;
            end
        end
    end
end
cs_tmp = [cs_part1; cs_part2];
cs_all = cs_tmp(:);
cs_redundant = zeros(N , 1);
cnt_cs = 1;
for i = 1 : length(cs_all)
    if (cs_all(i) >= seg_index(1)) && (cs_all(i) <= seg_index(end))
        cs_redundant(cnt_cs) = cs_all(i);
        cnt_cs = cnt_cs + 1;
    end
end
cs = cs_redundant(cs_redundant ~= 0);
cs = sort(cs);
end