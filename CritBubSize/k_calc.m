
NA = 6.022e23;  % atom/mole
Va = 0.0409; % nm^3/atom
kb = 8.6173324e-5;  %eV/atom K
Efg = 3.0;  %eV/atom
Efv = 3.0;  %eV/atom
Es = 400; %ev/nm^3: energy scale (64GPa)

T = 1800;  % K

Cmeqg = exp(-Efg/kb/T);  % mole fraction
Cmeqv = exp(-Efv/kb/T);  % mole fraction

C0g = 0.9999;
C0v = C0g;

a1 = 0.178605 + 0.0030782*log(C0g/(1-C0g));
a2 = 0.178605 + 0.00923461*log(C0g/(1-C0g));

A12 = (3*a1-a2)/(C0g - Cmeqg)/4 + T*(a2-a1)/2400/(C0g - Cmeqg);
B12 = A12;

kmg = A12;
kmv = B12;


eV2J = 1.6e-19;
nm2m = 1e-9;

kmg_J_m3 = kmg * eV2J / nm2m / nm2m / nm2m;


disp(kmg);
disp(kmg_J_m3);