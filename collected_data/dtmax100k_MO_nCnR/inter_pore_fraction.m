clear;
close all

fname = './MO/PFmulti_bubble_master_out.csv';
data_MO = table2array(readtable(fname));
fname = './nCnR/PFmulti_bubble_master_out.csv';
data_nCnR = table2array(readtable(fname));


time_MO = data_MO(:,1)./ 3600 ./24; %sec to days
time_nCnR = data_nCnR(:,1)./ 3600 ./24; %sec to days

intporefrac_MO = data_MO(:,3);
intporefrac_nCnR = data_nCnR(:,3);


figure(1)
plot(time_MO, intporefrac_MO, 'r-', 'LineWidth', 2);
hold on;
plot(time_nCnR, intporefrac_nCnR, 'g-', 'LineWidth', 2);



xlim([1 1400]);
ylim([0 .08]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular pore fraction', 'FontSize', 24);

legend('Standalone MARMOT', 'Xolotl coupled', 'Location', 'southeast');
hold off;



