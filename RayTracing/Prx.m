function [Mb,Sens] = Prx(Tx,Nos_Ondes,h,Ra)
%PRX Summary of this function goes here
% Calculation of the power received at the transmitter station. 
% On output, the code returns the power, its sensitivity and the associated
% baud rate.
%% Initialisation

F = 27*10^9; 
w = 2*pi*F; 
c = 3*10^8; 

% Calculate antenna gain and power.
% According to the course, the directivity of the antenna is 1.7 (theta = 90°).
% This means that the gain is the same as the directivity.

G_tx = Tx.gain;
P_tx = Tx.puissance_emmission;

% In the void, beta :

b = w/c;

%% Calculation of multi-component waves.
E = zeros(1,length(Nos_Ondes)); % Probleme 
for k = 1:length(Nos_Ondes)
    ray = Nos_Ondes{k};
    d = ray.d; % Distance travelled by the wave
    Gamma = ray.Gamma; % Reflection coefficient associated with the wave
    T = ray.T; % Wave transmission coefficient
    E(k) = Gamma*T*sqrt(60*G_tx*P_tx)*exp(-1i*b*d)/d; % Calculates the electric field for each ray
end

%% Power calculation.
% Sum of all fields received.
P_rx = (1/(8*Ra))*sum(abs(h*E).^2); % Average power received.

%% Transformation en DBm.
Sens = 10*log(P_rx)/log(10)+30; % Our sensitivity. between -73 and -82
if Sens < -82
    Sens = -82;
    Mb = 0;
elseif (-82 < Sens) && (Sens < -73)
    Sens= 10*log(P_rx)/log(10)+30;
    Mb = (Sens*280 + 23320)/9; % Our bit rate. 
    % The linear relationship is deduced from the values given since
else
    Sens = -73;
    Mb = 320; 
end

end