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

fname = './1000K/MO/PFmulti_bubble_master_out.csv';
data_MO1000 = table2array(readtable(fname));
fname = './1000K_csv/PP_nCnR.csv';
data_nCnR1000 = table2array(readtable(fname));
fname = './1000K_csv/PP_CnR_1000K.csv';
data_CnR1000 = table2array(readtable(fname));
%fname = './1000K_csv/PP_CR.csv';
fname = './1000K_csv/PP_CR_1000K.csv';
data_CR1000 = table2array(readtable(fname));

fname = './1800K_csv/tinyBub/MO.csv';
data_MO1800 = table2array(readtable(fname));
fname = './1800K_csv/tinyBub/PP_nCnR.csv';
data_nCnR1800 = table2array(readtable(fname));
fname = './1800K_csv/tinyBub/PP_CnR.csv';
data_CnR1800 = table2array(readtable(fname));
fname = './1800K_csv/tinyBub/PP_CR.csv';
data_CR1800 = table2array(readtable(fname));

time_MO1000 = data_nCnR1000(:,1)./ 3600 ./24; %sec to days
time_nCnR1000 = data_nCnR1000(:,1)./ 3600 ./24; %sec to days
time_CnR1000 = data_CnR1000(:,1)./ 3600 ./24; %sec to days
time_CR1000 = data_CR1000(:,1)./ 3600 ./24; %sec to days
time_MO1800 = data_MO1800(:,1)./ 3600 ./24; %sec to days
time_nCnR1800 = data_nCnR1800(:,1)./ 3600 ./24; %sec to days
time_CnR1800 = data_CnR1800(:,1)./ 3600 ./24; %sec to days
time_CR1800 = data_CR1800(:,1)./ 3600 ./24; %sec to days


bub_frac_MO1000 = data_nCnR1000(:,6);
bub_frac_nCnR1000 = data_nCnR1000(:,6);
bub_frac_CnR1000 = data_CnR1000(:,6);
bub_frac_CR1000 = data_CR1000(:,6);
bub_frac_MO1800 = data_MO1800(:,3);
bub_frac_nCnR1800 = data_nCnR1800(:,6);
bub_frac_CnR1800 = data_CnR1800(:,6);
bub_frac_CR1800 = data_CR1800(:,6);

XolVolFrac_nCnR1000 = data_nCnR1000(:,5);
XolVolFrac_CnR1000 = data_CnR1000(:,5);
XolVolFrac_CR1000 = data_CR1000(:,5);
XolVolFrac_nCnR1800 = data_nCnR1800(:,5);
XolVolFrac_CnR1800 = data_CnR1800(:,5);
XolVolFrac_CR1800 = data_CR1800(:,5);

bubConc_nCnR1000 = data_nCnR1000(:,3);
bubConc_CnR1000 = data_CnR1000(:,3);
bubConc_CR1000 = data_CR1000(:,3);
bubConc_nCnR1800 = data_nCnR1800(:,3);
bubConc_CnR1800 = data_CnR1800(:,3);
bubConc_CR1800 = data_CR1800(:,3);

XolConc_nCnR1000 = data_nCnR1000(:,4);
XolConc_CnR1000 = data_CnR1000(:,4);
XolConc_CR1000 = data_CR1000(:,4);
XolConc_nCnR1800 = data_nCnR1800(:,4);
XolConc_CnR1800 = data_CnR1800(:,4);
XolConc_CR1800 = data_CR1800(:,4);



figure(1)
plot(time_MO1800, bub_frac_MO1800, 'r-', 'LineWidth', 2);
hold on;
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
%ylabel('Gas cluster volume fraction', 'FontSize', 24);
%ylabel('Total gas concentration in bubbles', 'FontSize', 24);
ylabel('Total monomer concentration in fuel matrix', 'FontSize', 24);

legend('Stand-alone MARMOT', 'Coupled (No Clu. & No Re-s.)', 'Location', 'northwest');

figure(2)
plot(time_MO1800, bub_frac_MO1800, 'r-', 'LineWidth', 2);
hold on;
plot(time_CnR1800, bub_frac_CnR1800, 'g-', 'LineWidth', 6);
% % hold on;
plot(time_CR1800, bub_frac_CR1800, 'b-', 'LineWidth', 2);

xlim([0 1400]);
ylim([0 .07]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
%ylabel('Total monomer concentration in fuel matrix', 'FontSize', 24);
ylabel('Intergranular bubble fraction', 'FontSize', 24);
%ylabel('Intragranular bubble fraction', 'FontSize', 24);
%ylabel('Total gas concentration in bubbles', 'FontSize', 24);

legend({'Stand-alone MARMOT', 'Coupled (Clu. & No Re-s.)', 'Coupled (Clu. & Re-s.)'}, 'Location', 'southeast');

figure(3)
plot(time_CnR1800, bub_frac_CnR1800, 'g-', 'LineWidth', 6);
hold on;
plot(time_CR1800, bub_frac_CR1800, 'b-', 'LineWidth', 2);

xlim([0 1400]);
%ylim([0.0 .067]);

% set(gca,'XTick', time_in_days);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Intergranular bubble fraction', 'FontSize', 24);
%ylabel('Gas cluster volume fraction', 'FontSize', 24);
%ylabel('Monomer concentration in fuel matrix', 'FontSize', 24);
%ylabel('Total gas concentration in bubbles', 'FontSize', 24);

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