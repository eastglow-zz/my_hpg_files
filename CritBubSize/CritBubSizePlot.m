clear;
close all

fname = './1000K/1grain/0.333/OneBub_out.csv';
data_03_1000 = table2array(readtable(fname));
fname = './1000K/1grain/0.666/OneBub_out.csv';
data_06_1000 = table2array(readtable(fname));
fname = './1000K/1grain/1/OneBub_out.csv';
data_10_1000 = table2array(readtable(fname));
fname = './1000K/1grain/2/OneBub_out.csv';
data_20_1000 = table2array(readtable(fname));
fname = './1000K/1grain/3/OneBub_out.csv';
data_30_1000 = table2array(readtable(fname));

fname = './1800K/1grain/0.333/OneBub_out.csv';
data_03_1800 = table2array(readtable(fname));
fname = './1800K/1grain/0.666/OneBub_out.csv';
data_06_1800 = table2array(readtable(fname));
fname = './1800K/1grain/1/OneBub_out.csv';
data_10_1800 = table2array(readtable(fname));
fname = './1800K/1grain/2/OneBub_out.csv';
data_20_1800 = table2array(readtable(fname));
fname = './1800K/1grain/3/OneBub_out.csv';
data_30_1800 = table2array(readtable(fname));

time_03_1000 = data_03_1000(:,1)./ 3600 ./24; %sec to days
time_06_1000 = data_06_1000(:,1)./ 3600 ./24; %sec to days
time_10_1000 = data_10_1000(:,1)./ 3600 ./24; %sec to days
time_20_1000 = data_20_1000(:,1)./ 3600 ./24; %sec to days
time_30_1000 = data_30_1000(:,1)./ 3600 ./24; %sec to days
time_03_1800 = data_03_1800(:,1)./ 3600 ./24; %sec to days
time_06_1800 = data_06_1800(:,1)./ 3600 ./24; %sec to days
time_10_1800 = data_10_1800(:,1)./ 3600 ./24; %sec to days
time_20_1800 = data_20_1800(:,1)./ 3600 ./24; %sec to days
time_30_1800 = data_30_1800(:,1)./ 3600 ./24; %sec to days


bubfrac_03_1000 = data_03_1000(:,3);
bubfrac_06_1000 = data_06_1000(:,3);
bubfrac_10_1000 = data_10_1000(:,3);
bubfrac_20_1000 = data_20_1000(:,3);
bubfrac_30_1000 = data_30_1000(:,3);

bubfrac_03_1800 = data_03_1800(:,3);
bubfrac_06_1800 = data_06_1800(:,3);
bubfrac_10_1800 = data_10_1800(:,3);
bubfrac_20_1800 = data_20_1800(:,3);
bubfrac_30_1800 = data_30_1800(:,3);


figure(1)
plot(time_03_1000, bubfrac_03_1000, 'r-', 'LineWidth', 2);
hold on;
plot(time_06_1000, bubfrac_06_1000, 'g-', 'LineWidth', 2);
plot(time_10_1000, bubfrac_10_1000, 'b-', 'LineWidth', 2);
plot(time_20_1000, bubfrac_20_1000, 'k-', 'LineWidth', 2);
plot(time_30_1000, bubfrac_30_1000, 'y-', 'LineWidth', 2);


xlim([1 1400]);
%ylim([0 .067]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Bubble fraction @1000K', 'FontSize', 24);

legend('d/IW = 0.333', 'd/IW = 0.666', 'd/IW = 1.000', 'd/IW = 2.000', 'd/IW = 3.000', 'Location', 'east');
hold off;

figure(2)
plot(time_03_1800, bubfrac_03_1800, 'r-', 'LineWidth', 2);
hold on;
plot(time_06_1800, bubfrac_06_1800, 'g-', 'LineWidth', 2);
plot(time_10_1800, bubfrac_10_1800, 'b-', 'LineWidth', 2);
plot(time_20_1800, bubfrac_20_1800, 'k-', 'LineWidth', 2);
plot(time_30_1800, bubfrac_30_1800, 'y-', 'LineWidth', 2);

xlim([1 1400]);
%ylim([0 .07]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',20);
xlabel('Time (days)', 'FontSize', 24);
ylabel('Bubble fraction @1800K', 'FontSize', 24);


legend('d/IW = 0.333', 'd/IW = 0.666', 'd/IW = 1.000', 'd/IW = 2.000', 'd/IW = 3.000', 'Location', 'east');

