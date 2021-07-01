
%Data loading
[NP_CR,t_tot_CR,t_transfer_CR,t_wrap_CR,t_wrap_perc_CR,t_PF_CR,t_PF_perc_CR] = LoadData_strong_scaling_CR();

%Normalizing


tnorm_CR = t_tot_CR/t_tot_CR(1);


perf_CR = 1 ./tnorm_CR;


NP_ideal = [1 24];
perf_ideal = [1 24];
NP_CR = [1   4   8   12  16  20 24];
perf_CR = [1 2.9 5.5 8.6 11.2 13.5 15.6];
%Ideal data


%Plot
plot(NP_ideal, perf_ideal, 'k--');
hold on;

plot(NP_CR, perf_CR, 'b-o', 'LineWidth', 2, 'MarkerSize', 10);

xlim([1 25]);
ylim([1 25]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('# of processes (x 48)', 'FontSize', 24);
ylabel('Speedup', 'FontSize', 24);

legend({'Ideal', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');
%legend({'Ideal', 'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)'}, 'Location', 'northwest');