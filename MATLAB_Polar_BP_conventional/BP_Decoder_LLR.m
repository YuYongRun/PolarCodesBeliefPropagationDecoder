function [info_esti, denoised_llr, error, iter_this_time] = BP_Decoder_LLR(info_bits, frozen_bits, llr, max_iter, M_right_up, M_right_down, lambda_offset, llr_layer_vec)
N = length(frozen_bits);
n = log2(N);
R = zeros(N, n + 1);
L = zeros(N, n + 1);
%Initialize R
for i = 1:N
    if frozen_bits(i) == 1
        R(i, 1) = realmax;
    end
end
%Initialize L
L(:, n + 1) = llr;
%Iter
for iter = 1 : max_iter
    %Left Prop
    for j = n : -1 : 1 %for each layer
        for i = 1 : N/2 %for each 2*2 module in each layer
            up_index = M_right_up(i, j);
            down_index = M_right_down(i, j);
            R_2i_j = R(2 * i, j);
            R_2i_1_j = R(2 * i - 1, j);
            L_down_j_1 = L(down_index, j + 1);
            abs_L_up_index_j_1 = abs(L(up_index, j + 1));
            sign_L_up_index_j_1 = sign(L(up_index, j + 1));
            L(2 * i - 1, j) = 0.9375 * min(abs_L_up_index_j_1, abs(L_down_j_1 + R_2i_j)) *...
                sign_L_up_index_j_1 * sign(L_down_j_1 + R_2i_j);         
            L(2 * i, j) = L_down_j_1 + 0.9375 * min(abs_L_up_index_j_1, abs(R_2i_1_j)) * sign_L_up_index_j_1 * sign(R_2i_1_j);
        end
    end
    %Right Prop
    for j = 1 : n
        for i = 1 : N/2
            up_index = M_right_up(i, j);
            down_index = M_right_down(i, j);
            R_2i_j = R(2 * i, j);
            L_down_j_1 = L(down_index, j + 1);
            L_up_j_1 = L(up_index, j + 1);
            abs_R_2i_1_j = abs(R(2 * i - 1, j));
            sign_R_2i_1_j = sign(R(2 * i - 1, j));
            R(up_index, j + 1) = 0.9375 * min(abs(R_2i_j + L_down_j_1), abs_R_2i_1_j) *...
                sign(R_2i_j + L_down_j_1) * sign_R_2i_1_j;
            R(down_index, j + 1) = 0.9375 * min(abs_R_2i_1_j, abs(L_up_j_1)) * sign_R_2i_1_j * sign(L_up_j_1) + R_2i_j;
        end
    end
    x_esti = (L(:, n + 1) + R(:, n + 1)) < 0;
    u_esti = (L(:, 1) + R(:, 1)) < 0;
    x_enc = my_polar_encode(u_esti, lambda_offset, llr_layer_vec);
    if all(x_esti == x_enc)
        info_esti = u_esti(info_bits);
        denoised_llr = L(:, n + 1) + R(:, n + 1);
        error = 0;
        iter_this_time = iter;
        break;
    else
        if iter == max_iter
            info_esti = u_esti(info_bits);
            denoised_llr = L(:, n + 1) + R(:, n + 1);
            error = 1;
            iter_this_time = iter;
        end
    end
end
end