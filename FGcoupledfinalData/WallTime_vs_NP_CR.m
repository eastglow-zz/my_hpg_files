% Wall-time sharing v.s. addition of physics

%Data loading
[NP_MO, t_tot_MO] = LoadData_strong_scaling_MO();
[NP_NN, t_tot_NN, t_transfer_NN, t_wrap_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_strong_scaling_NN();
[NP_CnR,t_tot_CnR,t_transfer_CnR,t_wrap_CnR,t_wrap_perc_CnR,t_PF_CnR,t_PF_perc_CnR] = LoadData_strong_scaling_CnR();
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

% Cases for NP = 1
y_NN = [t_transfer_NN; t_PF_NN; t_wrap_NN];
y_CnR = [t_transfer_CnR; t_PF_CnR; t_wrap_CnR];
y_CR = [t_transfer_CR; t_PF_CR; t_wrap_CR];

y = [y_CR(:,1), y_CR(:,2), y_CR(:,3), y_CR(:,4), y_CR(:,5), y_CR(:,6)].';

x = categorical({'4','8','16','32','64','128'});
c = reordercats(x,{'4','8','16','32','64','128'});
% c = [{'1','2','4','8','16','32','64'}];
% x = [NP_NN(1),NP_NN(2),NP_NN(3),NP_NN(4),NP_NN(5),NP_NN(6),NP_NN(7)];
bar(c,y,'stacked', 'BarWidth', 0.8);

ylim([0 6000]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',22);
xlabel('# of processors', 'FontSize', 24);
ylabel('Computation time (s)', 'FontSize', 24);

legend({'Data transfer', 'MARMOT', 'Xolotl'}, 'Location', 'northeast','FontSize', 24);
title('Clu. & Re-s.','FontSize', 24);