% NP_NN = [1 2 16 32 64 128 256];
% t_tot_NN = [16723.183 11400.307 1497.794 919.326 630.154 525.432 930.962];
% t_PF_NN = [15528.827 10487.659 1269.519 670.244 384.551 254.61 328.074];
% t_Xolotl_NN = [786.706 601.821 133.348 160.734 171.478 190.312 376.668];

[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_strong_scaling_NN();


tnorm_totNN = t_tot_NN/t_tot_NN(1);
tnorm_PFNN = t_PF_NN/t_PF_NN(1);
tnorm_XolotlNN = t_Xolotl_NN/t_Xolotl_NN(1);

perf_totNN = 1 ./tnorm_totNN;
perf_PFNN = 1 ./tnorm_PFNN;
perf_XolotlNN = 1 ./tnorm_XolotlNN;
NP_ideal = [1 256];
perf_ideal = [1 256];

plot(NP_ideal, perf_ideal, 'k--');
hold on;
plot(NP_NN, perf_totNN, 'r-o','LineWidth', 2, 'MarkerSize', 10);
plot(NP_NN, perf_PFNN, 'r--');
plot(NP_NN, perf_XolotlNN, 'r-x', 'MarkerSize', 10);

xlim([1 64]);
ylim([1 64]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processors', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'Coupled (No Clu. & No Re-s.)', 'MOOSE-PF solver', 'Xolotl solver'}, 'Location', 'northwest');