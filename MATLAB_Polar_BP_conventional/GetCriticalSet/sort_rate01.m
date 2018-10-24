function [rate0_structure, rate1_structure] = sort_rate01(rate0, rate1)

[row0, ~] = size(rate0);
for i = 1:row0 - 1
    for j = i + 1: row0
        if rate0(i, 1) > rate0(j, 1)
            tmp = rate0(i, :);
            rate0(i, :) = rate0(j, :);
            rate0(j, :) = tmp;
        end
    end
end
rate0_structure = rate0;

[row1, ~] = size(rate1);
for i = 1:row1 - 1
    for j = i + 1: row1
        if rate1(i, 1) > rate1(j, 1)
            tmp = rate1(i, :);
            rate1(i, :) = rate1(j, :);
            rate1(j, :) = tmp;
        end
    end
end
rate1_structure = rate1;
end