
%Data loading
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

%Normalizing


tnorm_CR = t_tot_CR/t_tot_CR(1);


perf_CR = 1 ./tnorm_CR;


NP_ideal = [1 96*48];
perf_ideal = [1 1];
NP_CR = [12  24  48  96];
NP_CR = NP_CR*48;
perf_CR = [1 0.870158856 0.896181882 0.885712546];
%Ideal data


%Plot
plot(NP_ideal, perf_ideal, 'k--');
hold on;

plot(NP_CR, perf_CR, 'k-o', 'LineWidth', 2, 'MarkerSize', 10);

xlim([576 4700]);
ylim([0 2]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processes', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)'}, 'Location', 'northwest');