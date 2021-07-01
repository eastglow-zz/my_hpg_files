
length_scale = 1e-9;  %m/nm
eVpJ=6.24150934e+18; %eV/J

kb = 8.617e-5;  % Boltzmann constant, eV/K

energy_scale = 400; %ev/nm^3

sigma_Jm = 1.5;
delta_nm = 480;

%Diffusivity function of temperature
T = 1800; %K
F = 8e-9; % 1/nm^3/s
F = F/length_scale^3;

if (T > 1650)
    D = 7.6e-10 * exp(-3.04/kb/T);   % m^2/s
elseif (T <= 1650 && T > 1381)
    D = 4*(1.4e-25)*sqrt(F)*exp(-1.2/kb/T); % m^2/s
elseif (T <= 1381)
    D = 4*(2e-40)*F; % m^2/s
end

D = D / length_scale^2;

% D = 0.0078;  %nm^2/s

sigma_ev = sigma_Jm*eVpJ*length_scale^2;

kappa = (3/4)*sigma_ev*delta_nm/energy_scale;
mu = 6*sigma_ev/delta_nm/energy_scale;

Mint = D/sigma_ev;
L = Mint/(3*sqrt(2)*delta_nm);
Lstar = L*energy_scale;