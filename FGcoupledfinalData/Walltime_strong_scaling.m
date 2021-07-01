
%Data loading
[NP_MO, t_tot_MO] = LoadData_strong_scaling_MO();
[NP_NN, t_tot_NN, t_transfer_NN, t_wrap_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_strong_scaling_NN();
[NP_CnR,t_tot_CnR,t_transfer_CnR,t_wrap_CnR,t_wrap_perc_CnR,t_PF_CnR,t_PF_perc_CnR] = LoadData_strong_scaling_CnR();
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

%Plot
%plot(NP_MO, t_tot_MO, 'k-o', 'LineWidth', 2, 'MarkerSize', 10);
%hold on;
plot(NP_NN, t_wrap_NN, 'r-o', 'LineWidth', 2, 'MarkerSize', 10);
hold on;
plot(NP_CnR, t_wrap_CnR, 'g-o', 'LineWidth', 2, 'MarkerSize', 10);
plot(NP_CR, t_wrap_CR, 'b-o', 'LineWidth', 2, 'MarkerSize', 10);

scatter(128, 70.677, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'g');
scatter(128, 69.252, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'g');
scatter(128, 68.937, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'g');

scatter(128, 87.073, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'b');
scatter(128, 82.093, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'b');
scatter(128, 83.960, 100, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'b');

xlim([1 128]);
ylim([10 20000]);

a = get(gca,'XTickLabel');
set(gca,'Yscale','log');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processors', 'FontSize', 24);
ylabel('log(Xototl time (s))', 'FontSize', 24);

%legend({'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northeast');
legend({'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northeast');
%legend({'Ideal', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)'}, 'Location', 'northwest');