NP_NN = [9 18 36];
t_tot_GT = [1467.348 1467.054 1438.815];
t_tot_nGT = [2123.287 4767.428 20000];

%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_NN();
%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_CR();


tnorm_totGT = t_tot_GT/t_tot_GT(1);
tnorm_totnGT = t_tot_nGT/t_tot_nGT(1);

perf_totGT = 1 ./tnorm_totGT;
perf_totnGT = 1 ./tnorm_totnGT;

NP_ideal = [9 36];
perf_ideal = [1 1];

plot(NP_ideal, perf_ideal, 'k--');
hold on;
plot(NP_NN, perf_totGT, 'b-o','LineWidth', 2, 'MarkerSize', 10);
plot(NP_NN, perf_totnGT, 'r-x','LineWidth', 2, 'MarkerSize', 10);

xlim([9 36]);
ylim([0 2]);

set(gca,'XTick', NP_NN);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of grains', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'w/ GrainTracker', 'w/o GrainTracker'}, 'Location', 'northwest');