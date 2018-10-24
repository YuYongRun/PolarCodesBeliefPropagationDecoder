clear;
addpath('Decoding_Index/')
addpath('GA/')
addpath('GetCriticalSet/')
n = 12;
N = 2^n;%码长
K = 2^(n - 1);%信息长
max_iter = 100;%BP最大迭代次数
max_err = 200;%低信噪比仿真加速
max_runs = 1e3;%每个信噪比仿真点数
resolution = 1e5;
ebno_vec = 3;
[bler, ber] = Simulation(max_iter, max_err, max_runs, resolution, ebno_vec, N, K);


