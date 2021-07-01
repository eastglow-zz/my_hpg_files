% Wall-time sharing v.s. addition of physics

% walltime = [663.715 1816.658 0 3739.839 2898.752 1424.526];
% pmem = [1.094500e+04 1.104900e+04 0 1.111200e+04 1.101200e+04  1.084300e+04];
% vmem = [3.676900e+04 3.691600e+04 0 3.660800e+04 3.681000e+04  3.742300e+04];
% mem = pmem + vmem;
% solvetime = [570.399 1695.868 0 3571.924 2744.483 1342.198];
% restime = [87.986 729.777 0 1958.818 2169.488 1028.854];
% jactime = [403.925 344.836 0 509.535 231.594 104.446];


%walltime = [663.715 5419.085 67849.7]; %NEWTON
walltime = [1424.526 3784.443 18390.551];
%pmem = [1.094500e+04 1.256500e+04 1.780300e+04];
pmem = [1.084300e+04 1.219000e+04 1.336300e+04];
vmem = [3.676900e+04 3.691600e+04 0 ];
mem = pmem + vmem;

walltime_merge = [663.715, 1424.526
                  5419.085, 3784.443
                  67849.7, 18390.551];
pmem_merge = [1.094500e+04, 1.084300e+04
              1.256500e+04, 1.219000e+04
              1.780300e+04, 1.336300e+04];

x = categorical({'5','8','25'});
c = reordercats(x,{'5','8','25'});
%x = categorical({'NF5','NF8','NF25'});
%c = reordercats(x,{'NF5','NF8','NF25'});
% c = [{'1','2','4','8','16','32','64'}];
% x = [NP_NN(1),NP_NN(2),NP_NN(3),NP_NN(4),NP_NN(5),NP_NN(6),NP_NN(7)];
bar(c,walltime_merge, 'BarWidth', 0.8);

%ylim([0 2.5e4]);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',22);
xlabel('# of grains', 'FontSize', 24);
ylabel('Computation time (s)', 'FontSize', 24);

legend({'NEWTON full', 'PJFNK-3'}, 'Location', 'northwest','FontSize', 24);
%title('Clu. & No Re-s.','FontSize', 24);