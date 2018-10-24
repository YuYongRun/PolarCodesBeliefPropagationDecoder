function cs = get_critical_set(frozen_bits, seg_index)
[rate0_redundancy, rate1_redundancy] = get_node_01_structure(frozen_bits);
[rate0_not_sorted, rate1_not_sorted] = rate01_delete_redundancy(rate0_redundancy, rate1_redundancy);
[~, rate1_structure] = sort_rate01(rate0_not_sorted, rate1_not_sorted);
cs = get_cs(rate1_structure, frozen_bits, seg_index);
end