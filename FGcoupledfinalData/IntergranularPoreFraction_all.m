time_in_days = time ./ 3600 ./ 24;

plot(time_in_days, porefrac_MO, 'k-', 'LineWidth', 2);
hold on;
plot(time_in_days, porefrac_nCnR, 'r-', 'LineWidth', 2);
plot(time_in_days, porefrac_CnR, 'g-', 'LineWidth', 6);
% hold on;
plot(time_in_days, porefrac_CR, 'b-', 'LineWidth', 2);

xlim([0 1400]);
% ylim([0 2.2]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular Pore fraction', 'FontSize', 24);

legend({'MOOSE-standalone', 'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');