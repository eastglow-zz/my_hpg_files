
pi = 3.141592;
Ds = 2.3398;  % nm^2/s
F = 2e-9;  % in atoms/(nm^3 * s)
Rig = 1; %in nm
lf = 6; %in micron
Z0 = 1; %in nm
Nig = 7e23; % bubbles/m^3

lf_op = lf * 1000; % micron to nm
Nig_op = Nig/(1e9)^3;  % # bubbles/nm^3

goverb = 4*pi*Ds*Rig*Nig_op/(3.03*F*pi*lf_op*(Rig+Z0)^2);

Deff = Ds/(1+goverb);



length_scale = 1e-9;
time_scale = 1e-3;
eVpJ=6.24150934e+18; %eV/J

delta = 480; %nm
gamma_Jm2 = 1.5;

gamma = gamma_Jm2*eVpJ*length_scale^2; %eV/length_scale^2
Mint = Deff/gamma;
energy_scale = 400; % ev/nm^3
L = Mint/(3*sqrt(2)*delta);
Lstar = L*energy_scale;