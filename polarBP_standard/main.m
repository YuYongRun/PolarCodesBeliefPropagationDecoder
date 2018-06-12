clear;
n = 8;
N = 2^n;
K = 2^(n-1);
max_iter = 30;
max_err = 50;
max_runs = 2000;
ebno_vec = 2.5;
channels = get_BEC_IWi(N);
[info_bits, frozen_bits] = get_info_and_frozen_location(channels, N, K);
[bler, ber, num_ber] = Simulation(max_iter, max_err, max_runs, info_bits, frozen_bits, ebno_vec, N, K);
[ebno_vec', bler]

