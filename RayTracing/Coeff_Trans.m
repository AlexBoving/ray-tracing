function [Trans] = Coeff_Trans(obj,theta_i)
%COEFF_TRANS Summary of this function goes here
% Cette fonction renvoie simplement le coefficient de transmission.

%% Initialisation

Z_1 = 120*pi; % void impedance.
Z_2 = obj.Z_2; % Return object impedance value. 
F = 27*10^9; % Frequency.
w = 2*pi*F; % Omega.
c = 3*10^8; % Wave velocity.
b = w/c;  

% Vacuum permeability and permittivity.

mu0 = 1.25663706e-6; % Ici étaient nos erreurs.
ep0 = 8.85418782e-12; % Ici aussi.

% Permittivity of the material.

epsilon = obj.perm_relative*ep0;

% Calculation of alpha and beta.

alpha = w*sqrt(mu0*epsilon/2)*sqrt(sqrt(1+(obj.conductivite/(w*epsilon))^2) - 1);
beta = w*sqrt(mu0*epsilon/2)*sqrt(sqrt(1+(obj.conductivite/(w*epsilon))^2) + 1);

gamma = alpha + 1j*beta; % The propagation constant

theta_t = asin(sin(theta_i)/sqrt(obj.perm_relative));
s = 0.5/cos(theta_t); % 0.5 is the wall thickness.

%% Formulas and computation

% Reflection and transmission coefficients for perpendicular polarization. 
% The expressions for reflection and transmission.

Tref_orthogonal = (Z_2*cos(theta_i) - Z_1*cos(theta_t))/(Z_2*cos(theta_i) + Z_1*cos(theta_t));
% Ttrans_orthogonal = 2*Z_2cos(theta_i)/(Z_2*cos(theta_i) + Z_1*cos(theta_t));

%expo = Tref_orthogonal*exp(-2*gamma*s)*exp(1j*2*b*s*sin(theta_t)*sin(theta_i))

Trans = (1 - Tref_orthogonal^2)*exp(-gamma*s)/(1 - Tref_orthogonal^2*exp(-2*gamma*s)*exp(1j*2*b*s*sin(theta_t)*sin(theta_i)));

end