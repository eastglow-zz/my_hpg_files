% Wall-time sharing v.s. addition of physics

%Data loading
[NP_MO, t_tot_MO] = LoadData_strong_scaling_MO();
[NP_NN, t_tot_NN, t_transfer_NN, t_wrap_NN, t_wrap_perc_NN, t_PF_NN, t_PF_perc_NN] = LoadData_strong_scaling_NN();
[NP_CnR,t_tot_CnR,t_transfer_CnR,t_wrap_CnR,t_wrap_perc_CnR,t_PF_CnR,t_PF_perc_CnR] = LoadData_strong_scaling_CnR();
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

% Cases for NP = 1
y_NN = [t_transfer_NN(1)];
y_CnR = [t_transfer_CnR(1)];
y_CR = [t_transfer_CR(1)];

y = [y_NN; y_CnR; y_CR];

x = categorical({'No Clu. & No Re-s.','Clu. & No Re-s.','Clu. & Re-s.'});
c = reordercats(x, {'No Clu. & No Re-s.','Clu. & No Re-s.','Clu. & Re-s.'});
bar(c,y,'stacked', 'BarWidth', 0.4);

ylim([0 10]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',18);
xlabel('Physics considered', 'FontSize', 22);
ylabel('Computation time (s)', 'FontSize', 22);

legend({'Data transfer'}, 'Location', 'northeast','FontSize', 24);