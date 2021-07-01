NP_CR = [0 2 5 8];
t_tot_CR = [847.2 2638.262 5448.221 8584.937];
t_Xolotl_CR = [204.081 214.298 138.359 170.095];
t_PF_CR = [514.819 2343.254 5161.791 8175.562];

%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_NN();
%[NP_NN, t_tot_NN, t_transfer_NN, t_Xolotl_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_weak_scaling_CR();


tnorm_totCR = t_tot_CR/t_tot_CR(1);
tnorm_Xolotl_CR = t_Xolotl_CR/t_Xolotl_CR(1);
tnorm_PF_CR = t_PF_CR/t_PF_CR(1);

perf_totCR = 1 ./tnorm_totCR;
perf_Xolotl_CR = 1 ./tnorm_Xolotl_CR;
perf_PF_CR = 1 ./tnorm_PF_CR;

plot(NP_CR, t_tot_CR, 'k-o','LineWidth', 2, 'MarkerSize', 10);
hold on;
plot(NP_CR, t_PF_CR, 'b-x','LineWidth', 2, 'MarkerSize', 10);
plot(NP_CR, t_Xolotl_CR, 'r-x','LineWidth', 2, 'MarkerSize', 10);
xlim([0 8]);
ylim([0 10000]);


set(gca,'XTick', NP_CR);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of elements along z-axis', 'FontSize', 24);
ylabel('Wall time (s)', 'FontSize', 24);
legend({'Total time', 'Phase-field calc.', 'Xolotl calc.'}, 'Location', 'northwest');


