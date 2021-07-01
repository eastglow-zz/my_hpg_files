clear;
close all

% fname = 'PoreFractionAll.xlsx';
% dmp=xlsread('PoreFractionAll.xlsx');
% 
% time = dmp(:,1);
% vol_frac = dmp(:,2:end);

% fname = 'moose_standalone_new.csv';
% dmp1 = importdata(fname);
% 
% fname = 'moose_standalone_nomask.csv';
% dmp2 = importdata(fname);

fname = 'PP_MO_fix.csv';
data_MO = table2array(readtable(fname));
fname = 'PP_nCnR_new_fix.csv';
data_nCnR = table2array(readtable(fname));
fname = 'PP_CnR.csv';
data_CnR = table2array(readtable(fname));
fname = 'PP_CR.csv';
data_CR = table2array(readtable(fname));

time_MO = data_MO(:,1) ./ 3600 ./24; %sec to days
time_nCnR = data_nCnR(:,1)./ 3600 ./24; %sec to days
time_CnR = data_CnR(:,1)./ 3600 ./24; %sec to days
time_CR = data_CR(:,1)./ 3600 ./24; %sec to days
vol_frac_MO = data_MO(:,3);
vol_frac_nCnR = data_nCnR(:,3);
vol_frac_CnR = data_CnR(:,3);
vol_frac_CR = data_CR(:,3);

time_in_days = time_MO ./ 3600 ./ 24;

figure(1)
plot(time_MO, vol_frac_MO, 'k-', 'LineWidth', 2);
hold on;
plot(time_nCnR, vol_frac_nCnR, 'r-', 'LineWidth', 2);
% plot(time_new/(3600*24), vol_frac_new-.02, 'k--', 'LineWidth', 2);
% plot(time_in_days, porefrac_CnR, 'g-', 'LineWidth', 6);
% % hold on;
% plot(time_in_days, porefrac_CR, 'b-', 'LineWidth', 2);

xlim([0 1400]);
%ylim([0 .067]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular bubble fraction', 'FontSize', 24);

legend('Stand-alone MARMOT', 'Coupled (No Clu. & No Re-s.)', 'Location', 'northwest');

figure(2)
plot(time_nCnR, vol_frac_nCnR, 'r-', 'LineWidth', 2);
hold on;
plot(time_CnR, vol_frac_CnR, 'g-', 'LineWidth', 6);
% % hold on;
plot(time_CR, vol_frac_CR, 'b-', 'LineWidth', 2);

xlim([0 1400]);
%ylim([0 .067]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular bubble fraction', 'FontSize', 24);

legend({'Coupled (No Clu. & No Re-s.)', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'northwest');

figure(3)
plot(time_CnR, vol_frac_CnR, 'g-', 'LineWidth', 2);
hold on;
plot(time_CR, vol_frac_CR, 'b-', 'LineWidth', 2);

xlim([0 1400]);
ylim([0.066 .077]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular bubble fraction', 'FontSize', 24);

legend('Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)', 'Location', 'southeast');

% figure(3)
% plot(dmp1.data(:,1)/(3600*24), dmp1.data(:,4), '-', 'LineWidth', 2);
% hold on
% 
% plot(dmp2.data(:,1)/(3600*24), dmp2.data(:,4), '-', 'LineWidth', 2);
% % plot(time_in_days, porefrac_CnR, 'g-', 'LineWidth', 6);
% % % hold on;
% % plot(time_in_days, porefrac_CR, 'b-', 'LineWidth', 2);
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
% xlabel('Time (days)', 'FontSize', 24);
% ylabel('Intergranular Pore fraction', 'FontSize', 24);