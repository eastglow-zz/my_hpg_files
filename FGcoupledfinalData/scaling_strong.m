
%Data loading
[NP_MO, t_tot_MO] = LoadData_strong_scaling_MO();
[NP_NN, t_tot_NN, t_transfer_NN, t_wrap_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_strong_scaling_NN();
[NP_CnR,t_tot_CnR,t_transfer_CnR,t_wrap_CnR,t_wrap_perc_CnR,t_PF_CnR,t_PF_perc_CnR] = LoadData_strong_scaling_CnR();
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

%Normalizing
tnorm_MO = t_tot_MO/t_tot_MO(1);

tnorm_NN = t_tot_NN/t_tot_NN(1);
tnorm_transfer_NN = t_transfer_NN/t_transfer_NN(1);

tnorm_CnR = t_tot_CnR/t_tot_CnR(1);

tnorm_CR = t_tot_CR/t_tot_CR(1);

perf_MO = 1 ./tnorm_MO;
perf_NN = 1 ./tnorm_NN;
perf_CnR = 1 ./tnorm_CnR;
perf_CR = 1 ./tnorm_CR;

%Ideal data
NP_ideal = [1 128];
perf_ideal = [1 32];

%Plot
plot(NP_ideal, perf_ideal, 'k--');
hold on;
plot(NP_MO, perf_MO, 'k-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_NN, perf_NN, 'r-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_CnR, perf_CnR, 'g-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_CR, perf_CR, 'b-o', 'LineWidth', 2, 'MarkerSize', 10);

xlim([1 128]);
ylim([1 60]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processors', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)'}, 'Location', 'northwest');