function [NP, t_tot, t_transfer, t_wrap, t_wrap_perc, t_PF, t_PF_perc] = LoadData_strong_scaling_NN()

% NP = [1 2 4 8 16 32 64 128];
% t_tot = [8929.534 4650.883 2366.227 1259.322 670.182 429.293 316.775 282.246];
% t_transfer = [10.181 5.855 3.675 2.791 2.352 2.415 2.482 2.672];
% t_wrap= [367.544 250.43 140.283 87.408 64.483 78.138 116.724 128.785];
% t_wrap_perc = [4.12 5.38 5.93 6.94 9.62 18.2 36.85 45.63];
% t_PF = [8376.081 4300.047 2167.754 1137.184 577.509 327.704 178.896 132.075];
% t_PF_perc = [93.8 92.46 91.61 90.3 86.17 76.34 56.47 46.79];

 t_PF = [1546.476 803.101 534.286 269.511 141.09 47.116];

NP = [4 8 16 32 64 128];
t_tot = [3484.466 1422.089 809.362 354.064 175.36 66.794];

t_transfer = [5.48 4.416 5.13 4.982 5.034 5.715];

t_wrap= [1932.51 614.572 269.946 79.571 29.236 13.963];

t_wrap_perc = [4.97	6.19	9.02	11.09	14.34	23.58];
t_PF_perc = [91.42	87.69	79.61	57.78	67.36	43.14];

end