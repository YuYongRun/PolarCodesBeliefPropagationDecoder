function [bler, ber, num_ber] = Simulation(max_iter, max_err, max_runs, info_bits, frozen_bits, ebno_vec, N, K)

snr_db_vec = ebno_vec + 10*log10(K/N);
num_block_err = zeros(length(ebno_vec), 1);
num_bit_err = zeros(length(ebno_vec), 1);
num_runs = zeros(length(ebno_vec), 1);
M = index_Matrix(N);
num_ber = zeros(K, 1);

for i_run = 1 : max_runs
    
    if mod(i_run, ceil(max_runs/10)) == 1
        disp(['Sim iteration running = ', num2str(i_run)]);
        disp('Current BLER')
        disp(num2str([ebno_vec num_block_err./num_runs]))
    end
    
    waiting_encode = zeros(N, 1);
    info = rand(K, 1) < 0.5 ;
    waiting_encode(info_bits) = info;
    coded_bits = polar_encode(waiting_encode);
    bpsk = 2 * coded_bits - 1;
    sigma = sqrt(1/2);
    noise = sigma * randn(1, N);
    
    for i_ebno = 1 : length(ebno_vec)
        
        if num_block_err(i_ebno) > max_err
            continue;
        end
        
        num_runs(i_ebno) = num_runs(i_ebno) + 1;
        snr_db = snr_db_vec(i_ebno);
        received_bits = 10^(snr_db/20) * bpsk + noise;
        p1 = exp(-(received_bits - 10^(snr_db/20)).^2/(2 * sigma^2))/sigma/sqrt(2*pi);
        p0 = exp(-(received_bits + 10^(snr_db/20)).^2/(2 * sigma^2))/sigma/sqrt(2*pi);
        info_esti = BP_Decoder_LLR(info_bits, frozen_bits, log(p0./p1), max_iter, M);
        err = any(info ~= info_esti);
            if err
                num_block_err(i_ebno) =  num_block_err(i_ebno) + 1;
                num_bit_err(i_ebno) = num_bit_err(i_ebno) + sum(info ~= info_esti);
                num_ber(sum(info ~= info_esti)) = num_ber(sum(info ~= info_esti)) + 1;
            end
    end  
end
bler = num_block_err./num_runs;
ber = num_bit_err./num_runs/K;
% info_bits
end
