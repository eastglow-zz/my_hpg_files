
[NP_MO, t_tot_MO] = LoadData_weak_scaling_MO();
[NP_NN, t_tot_NN, t_transfer_NN, t_wrap_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_NN();
[NP_CnR, t_tot_CnR, t_transfer_CnR, t_wrap_CnR, t_wrap_perc_CnR, t_PF_CnR, t_PF_perc_CnR] = LoadData_weak_scaling_CnR();
[NP_CR, t_tot_CR, t_transfer_CR, t_wrap_CR, t_wrap_perc_CR, t_PF_CR, t_PF_perc_CR] = LoadData_weak_scaling_CR();

tnorm_tot_MO = t_tot_MO/t_tot_MO(1);
tnorm_tot_NN = t_tot_NN/t_tot_NN(1);
tnorm_tot_CnR = t_tot_CnR/t_tot_CnR(1);
tnorm_tot_CR = t_tot_CR/t_tot_CR(1);

perf_MO = 1 ./tnorm_tot_MO;
perf_NN = 1 ./tnorm_tot_NN;
perf_CnR = 1 ./tnorm_tot_CnR;
perf_CR = 1 ./tnorm_tot_CR;

NP_ideal = [1 256];
perf_ideal = [1 1];

plot(NP_ideal, perf_ideal, 'k--');
hold on;
plot(NP_MO, perf_MO, 'k-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_NN, perf_NN, 'r-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_CnR, perf_CnR, 'g-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_CR, perf_CR, 'b-o', 'LineWidth', 2, 'MarkerSize', 10);

xlim([4 100]);
ylim([0 2.2]);

set(gca,'XTick', NP_MO);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processors', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'Stand-alone MARMOT', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal','Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');

