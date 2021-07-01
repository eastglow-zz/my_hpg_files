% Wall-time sharing v.s. addition of physics

walltime = [663.715 1816.658 0 3739.839 2898.752 1424.526];
pmem = [1.094500e+04 1.104900e+04 0 1.111200e+04 1.101200e+04  1.084300e+04];
vmem = [3.676900e+04 3.691600e+04 0 3.660800e+04 3.681000e+04  3.742300e+04];
mem = pmem + vmem;
solvetime = [570.399 1695.868 0 3571.924 2744.483 1342.198];
restime = [87.986 729.777 0 1958.818 2169.488 1028.854];
jactime = [403.925 344.836 0 509.535 231.594 104.446];

x = categorical({'NF','PF','Pd','P1','P2','P3'});
c = reordercats(x,{'NF','PF','Pd','P1','P2','P3'});
% c = [{'1','2','4','8','16','32','64'}];
% x = [NP_NN(1),NP_NN(2),NP_NN(3),NP_NN(4),NP_NN(5),NP_NN(6),NP_NN(7)];
bar(c,pmem,'stacked', 'BarWidth', 0.8);

%ylim([1.05e4 1.15e4]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',22);
xlabel('Cases', 'FontSize', 24);
ylabel('Memory', 'FontSize', 24);

%legend({'Data transfer', 'MARMOT', 'Xolotl'}, 'Location', 'northeast','FontSize', 24);
%title('Clu. & No Re-s.','FontSize', 24);