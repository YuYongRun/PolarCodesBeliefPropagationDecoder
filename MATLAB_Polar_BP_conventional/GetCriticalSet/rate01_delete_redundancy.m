function [rate0_structure, rate1_structure] = rate01_delete_redundancy(rate0, rate1)
[row0, ~] = size(rate0);

for i = 1:row0 - 1
    kaishi = rate0(i, 1);
    jieshu = kaishi + rate0(i, 2) - 1;
    for j = i + 1:row0
        if (rate0(j, 1) >= kaishi) && (rate0(j, 1) + rate0(j, 2) - 1<= jieshu)
            rate0(j,:) = [-1 -1];
        end
    end
end

a = rate0(rate0 > 0);
rate0_structure(: ,1) = a(1:end/2);
rate0_structure(:, 2) = a(end/2 + 1:end);

[row1, ~] = size(rate1);

for i = 1:row1 - 1
    kaishi = rate1(i, 1);
    jieshu = kaishi + rate1(i, 2) - 1;
    for j = i + 1:row1
        if (rate1(j, 1) >= kaishi) && (rate1(j, 1) + rate1(j, 2) - 1<= jieshu)
            rate1(j,:) = [-1 -1];
        end
    end
end

a = rate1(rate1 > 0);
rate1_structure(: ,1) = a(1:end/2);
rate1_structure(:, 2) = a(end/2 + 1 :end);

end