NP_NN = [0 2 5 8];
t_tot_NN = [609.506 2407.614 5299.536 9397.584];
t_Xolotl_NN = [87.418 114.706 154.730 209.804];
t_PF_NN = [410.566 2235.458 5008.307 8925.924];

%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_NN();
%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_CR();


tnorm_totNN = t_tot_NN/t_tot_NN(1);
tnorm_Xolotl_NN = t_Xolotl_NN/t_Xolotl_NN(1);
tnorm_PF_NN = t_PF_NN/t_PF_NN(1);

perf_totNN = 1 ./tnorm_totNN;
perf_Xolotl_NN = 1 ./tnorm_Xolotl_NN;
perf_PF_NN = 1 ./tnorm_PF_NN;

plot(NP_NN, t_tot_NN, 'k-o','LineWidth', 2, 'MarkerSize', 10);
hold on;
plot(NP_NN, t_PF_NN, 'b-x','LineWidth', 2, 'MarkerSize', 10);
plot(NP_NN, t_Xolotl_NN, 'r-x','LineWidth', 2, 'MarkerSize', 10);
xlim([0 8]);
ylim([0 10000]);


set(gca,'XTick', NP_NN);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of elements along z-axis', 'FontSize', 24);
ylabel('Wall time (s)', 'FontSize', 24);
legend({'Total time', 'Phase-field calc.', 'Xolotl calc.'}, 'Location', 'northwest');


