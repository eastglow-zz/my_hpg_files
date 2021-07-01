NP_MO = [16 32 64];
t_tot_MO_hpg1 = [536.732 391.352 208.163];
t_tot_MO_hpg2 = [227.206 136.218 77.232];

tnorm_MO_hpg1 = t_tot_MO_hpg1/t_tot_MO_hpg1(1);
tnorm_MO_hpg2 = t_tot_MO_hpg2/t_tot_MO_hpg2(1);

NP_ideal = [16 64];
perf_ideal = [1 4];

perf_MO_hpg1 = 1 ./tnorm_MO_hpg1;
perf_MO_hpg2 = 1 ./tnorm_MO_hpg2;

plot(NP_ideal, perf_ideal, 'k--');
hold on;
plot(NP_MO, perf_MO_hpg1, 'k-o');
plot(NP_MO, perf_MO_hpg2, 'r-o');

xlim([16 64]);
ylim([1 4]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',18);
xlabel('# of CPUs', 'FontSize', 22);
ylabel('Speed-up', 'FontSize', 22);

legend({'Ideal', 'HPG1', 'HPG2'}, 'Location', 'northwest');