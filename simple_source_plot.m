clear;
close all

fname = './simple_source_csv/0/case_0_out.csv';
data_00 = table2array(readtable(fname));
fname = './simple_source_csv/05/case_0_out.csv';
data_05 = table2array(readtable(fname));
fname = './simple_source_csv/04/case_0_out.csv';
data_04 = table2array(readtable(fname));
fname = './simple_source_csv/03/case_0_out.csv';
data_03 = table2array(readtable(fname));
fname = './simple_source_csv/02/case_0_out.csv';
data_02 = table2array(readtable(fname));
fname = './simple_source_csv/01/case_0_out.csv';
data_01 = table2array(readtable(fname));
fname = './simple_source_csv/1/case_0_out.csv';
data_1 = table2array(readtable(fname));
fname = './simple_source_csv/2/case_0_out.csv';
data_2 = table2array(readtable(fname));


time_00 = data_00(:,1); 
time_05 = data_05(:,1); 
time_04 = data_04(:,1); 
time_03 = data_03(:,1); 
time_02 = data_02(:,1); 
time_01 = data_01(:,1); 
time_1 = data_1(:,1); 
time_2 = data_2(:,1); 

pf_00 = data_00(:,13); 
pf_05 = data_05(:,13); 
pf_04 = data_04(:,13); 
pf_03 = data_03(:,13); 
pf_02 = data_02(:,13); 
pf_01 = data_01(:,13); 
pf_1 = data_1(:,13); 
pf_2 = data_2(:,13); 

cv_00 = data_00(:,3); 
cv_05 = data_05(:,3); 
cv_04 = data_04(:,3); 
cv_03 = data_03(:,3); 
cv_02 = data_02(:,3); 
cv_01 = data_01(:,3); 
cv_1 = data_1(:,3); 
cv_2 = data_2(:,3); 

figure(1)
plot(time_00, pf_00, 'k-',  'LineWidth', 2);
hold on;
plot(time_05, pf_05,  'LineWidth', 2);
plot(time_04, pf_04, 'LineWidth', 2);
plot(time_03, pf_03, 'LineWidth', 2);
plot(time_02, pf_02, 'LineWidth', 2);
plot(time_01, pf_01, 'LineWidth', 2);
plot(time_1, pf_1, 'LineWidth', 2);
plot(time_2, pf_2, 'LineWidth', 2);


a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (microseconds)', 'FontSize', 24);
ylabel('Void fraction', 'FontSize', 24);

legend('0', '1e-3','1e-2','1e-1','1','10','100','1000', 'Location', 'southeast');
% legend('0.05', 'Location', 'northeast');
hold off;

figure(2)
plot(time_00, cv_00, 'k-', 'LineWidth', 2);
hold on;
plot(time_05, cv_05, 'LineWidth', 2);
plot(time_04, cv_04, 'LineWidth', 2);
plot(time_03, cv_03, 'LineWidth', 2);
plot(time_02, cv_02, 'LineWidth', 2);
plot(time_01, cv_01, 'LineWidth', 2);
plot(time_1, cv_1, 'LineWidth', 2);
plot(time_2, cv_2, 'LineWidth', 2);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (microseconds)', 'FontSize', 24);
ylabel('Average vacancy concentration', 'FontSize', 24);
legend('0', '1e-3','1e-2','1e-1','1','10','100','1000', 'Location', 'southeast');
