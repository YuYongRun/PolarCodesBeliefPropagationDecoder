function x = polar_encode(info_bits_padded)
N = length(info_bits_padded);
if (N == 1)
    x = info_bits_padded;
else
    u1u2 = mod(info_bits_padded(1:2:end) + info_bits_padded(2:2:end) , 2);
    u2 = info_bits_padded(2:2:end);
    x = [polar_encode(u1u2) polar_encode(u2)];
end
end