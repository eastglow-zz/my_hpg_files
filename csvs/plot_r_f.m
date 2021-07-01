clear;
close all

fname = './0.05/nucl_barrier_out.csv';
data_05 = table2array(readtable(fname));
fname = './0.10/nucl_barrier_out.csv';
data_10 = table2array(readtable(fname));
fname = './0.15/nucl_barrier_out.csv';
data_15 = table2array(readtable(fname));
fname = './0.20/nucl_barrier_out.csv';
data_20 = table2array(readtable(fname));
fname = './0.25/nucl_barrier_out.csv';
data_25 = table2array(readtable(fname));

time_05 = data_05(:,1); 
time_10 = data_10(:,1); 
time_15 = data_15(:,1); 
time_20 = data_20(:,1); 
time_25 = data_25(:,1); 

pf_05 = data_05(:,7);
pf_10 = data_10(:,7);
pf_15 = data_15(:,7);
pf_20 = data_20(:,7);
pf_25 = data_25(:,7);

totvol = 2*2;
pi = 3.141592;
r_05 = sqrt(pf_05*totvol/pi);
r_10 = sqrt(pf_10*totvol/pi);
r_15 = sqrt(pf_15*totvol/pi);
r_20 = sqrt(pf_20*totvol/pi);
r_25 = sqrt(pf_25*totvol/pi);

ftot_05 = data_05(:,8);
ftot_10 = data_10(:,8);
ftot_15 = data_15(:,8);
ftot_20 = data_20(:,8);
ftot_25 = data_25(:,8);

figure(1)
plot(time_05, r_05, 'r-', 'LineWidth', 2);
% hold on;
% plot(time_10, r_10, 'k-', 'LineWidth', 2);
% plot(time_15, r_15, 'k-', 'LineWidth', 2);
% plot(time_20, r_20, 'k-', 'LineWidth', 2);
% plot(time_25, r_25, 'k-', 'LineWidth', 2);



% xlim([5e-8 0.05]);
% ylim([0.35 0.6]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (ms)', 'FontSize', 24);
ylabel('Radius (nm)', 'FontSize', 24);

% legend('0.05', '0.10','0.15','0.20','0.25', 'Location', 'southeast');
legend('0.05', 'Location', 'northeast');
% hold off;

figure(2)
% plot(time_05, ftot_05, 'r-', 'LineWidth', 2);
scatter(time_05, ftot_05, 'r');
% xlim([5e-8 0.05]);
ylim([0.35 0.6]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (ms)', 'FontSize', 24);
ylabel('Ftot', 'FontSize', 24);
legend('0.05', 'Location', 'northeast');


figure(3)
plot(time_10, r_10, 'k-', 'LineWidth', 2);
% hold on;
% plot(time_10, r_10, 'k-', 'LineWidth', 2);
% plot(time_15, r_15, 'k-', 'LineWidth', 2);
% plot(time_20, r_20, 'k-', 'LineWidth', 2);
% plot(time_25, r_25, 'k-', 'LineWidth', 2);



% xlim([5e-8 0.05]);
% ylim([0.35 0.6]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (ms)', 'FontSize', 24);
ylabel('Radius (nm)', 'FontSize', 24);

% legend('0.05', '0.10','0.15','0.20','0.25', 'Location', 'southeast');
legend('0.10', 'Location', 'northeast');
% hold off;

figure(4)
% plot(time_05, ftot_05, 'r-', 'LineWidth', 2);
scatter(time_10, ftot_10, 'k');
% xlim([5e-8 0.05]);
% ylim([0.35 0.6]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (ms)', 'FontSize', 24);
ylabel('Ftot', 'FontSize', 24);
legend('0.10', 'Location', 'northeast');

figure(5)
scatter(r_05, ftot_05, 'r');
hold on;
scatter(r_10, ftot_10, 'k');
% scatter(r_15, ftot_15, 'k');
% scatter(r_20, ftot_20, 'k');
% scatter(r_25, ftot_25, 'k');


a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Radius (nm)', 'FontSize', 24);
ylabel('Ftot', 'FontSize', 24);
legend('0.05','0.10', 'Location', 'northwest');