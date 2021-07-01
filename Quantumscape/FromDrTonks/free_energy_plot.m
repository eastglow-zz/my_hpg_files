clear;
close all;

Ef = 1.6; %eV
Va = 0.005586; %atoms per nm^3
kb = 8.6173303e-5; 
T = 300; %K
length_scale = 1e-9;
time_scale = 1e-3;

% A = 2.3529/0.011635;
A = 1000;

cv = -0.2:0.0001:1.2;

fbulk = Ef/Va*cv + kb*T/Va*(cv.*log(cv) + (1-cv).*log(1-cv));
eps = 0.01;
fbulk_fit = 270.5*(sqrt(cv.^2 + eps^2) - eps) + 32/2*cv.*cv;
fbulk_para = A/2*(cv-0).^2;
fd_para = A/2*(cv-0.05).^2;
tol = 1e-3;
plog = log(tol) + (cv - tol)/tol - ((cv - tol).^2)/(2*tol*tol) + ((cv-tol).^3)/(3*tol*tol*tol);
fbulk_plog = Ef/Va*cv + kb*T/Va*(cv.*plog + (1-cv).*plog);
fvoid = A/2*(cv-1.0).^2;
fvoid_fit = 270.5*(sqrt((cv-1).^2 + eps^2) - eps) + 32/2*(cv-1).*(cv-1);
% plot(cv,fbulk, cv,fvoid,'linewidth',2)
% plot(cv,fbulk_fit, cv,fvoid,'linewidth',2)
% plot(cv,fbulk, cv,fbulk_fit,'linewidth',2)
% plot(cv,fbulk_para,'linewidth',2)
plot(cv,fbulk_fit,'linewidth',2)
hold on;
% plot(cv,fd_para, 'linewidth',2);
plot(cv,fvoid, 'linewidth',2);
ylim([-300,290]);
% xlim([0,1]);
set(gca,'fontsize',18)
xlabel('c_v (molar fraction)')
ylabel('Free energy (eV/nm^3)')
% legend('f_B','f_{d}','f_{V}','location','north')
legend('f_B','f_{V}','location','north')
legend boxoff

%Mobility
eVpJ=6.24150934e+18; %eV/J
Na = 6.02214076e23;%1/mol
Q = 240200; %J/mol
D0 = 1.39; %cm^2/s 

QeV = Q*eVpJ/Na;
D0 = D0*(1e-2/length_scale)^2*time_scale; %nm^2/s

D = D0*exp(-(QeV-Ef)/(kb*T));
cv_av = 1e-5;
M = cv_av*D/(kb*T)/Va;

%Surface energy
delta = 0.6928; %nm
gamma_f = [2.4 2.0]; %Surface energy J/m^2
gamma_T = [300 910+273.15]; %Corresponding temps
gamma_p = polyfit(gamma_T,gamma_f,1);
gamma = polyval(gamma_p,T);
gamma = gamma*eVpJ*length_scale^2; %eV/length_scale^2

kappa = 3*sqrt(2)*gamma*delta;
w = 3*sqrt(2)*gamma/delta;
Mint = D/gamma
L = Mint/(3*sqrt(2)*delta);

