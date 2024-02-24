%% Description du projet. 

% This is the algorithm used for Ray-Tracing with the
% image method.

%% Initialisation.

tic

% Look up the technical specifications for more information about the
% values.

% Frequency initialization.

F = 27*10^9; % This is the frequency of our Wifi wave emitted by the antenna. 
w = 2*pi*F; % The pulse.

% Wave initialization.

c = 3*10^8; % Wave velocity
Z_0 = 120*pi; % Void impedance
mu0 = 1.25663706e-6; 
ep0 = 8.85418782e-12; 
lambda = c/F; % Wavelength

% Antenna initialisation.

h = -lambda/pi; % Characteristic height. where theta = pi/2.
Ra = 73; % Radiation resistance.
Tx = Base([100,55]); % The location of our transmitting station. Tx is an object.

% Walls initialization.

perm_relative_brique = 4.6; % Bric.
perm_relative_beton = 5; % Concrete.

% Conductivity (sigma) of the materials.

conductivite_brique = 0.02; % Brick.
conductivite_beton = 0.014; % Concrete.

%% Treatment.

% Walls creation.

[wallxyz1,wallxyz2,wallX,wallY] = CSVexcel;

[M,N] = size(wallxyz1); % M : Number of walls. N : Number of columns.

% Initialize a cell matrix (for wall objects).
% It's important to initialize Mur correctly, otherwise it will create a new 
% a new variable to store a wall object. This code is already 
% code, you need to optimize it as much as possible.

% Initialization of object wall matrix.

a = zeros(1,length(wallxyz2));
Mur = num2cell(a); 

for i = 1:M 
   if i < 26 % The first 26 walls are made of concrete. 
       Mur{i} = Wall(wallxyz1(i,1:N),wallxyz2(i,1:N),perm_relative_beton,conductivite_beton,Z_0,w,ep0);
   else % The rest is brick.
       Mur{i} = Wall(wallxyz1(i,1:N),wallxyz2(i,1:N),perm_relative_brique,conductivite_brique,Z_0,w,ep0);
   end
end

% Loaded with Rx receivers. (No collisions with walls)

S = zeros(max(max(wallX)),max(max(wallY)));
Matrice_recepteur = num2cell(S);
for i = 0:1:max(max(wallX))
    for j = 0:1:max(max(wallY)) 
       Matrice_recepteur{i+1,j+1} = Recepteur([i,j]);
       % scatter(i,j,300);
    end
end

% Application of the image method (vector method). + Calculation of
% received power.

Mb = zeros(max(max(wallX))+1,max(max(wallY))+1);
Sens = zeros(max(max(wallX)+1),max(max(wallY))+1);
Sens(max(max(wallX)+1,max(max(wallY)+1))) = -82;

for a = 1:max(max(wallX))
    disp(a)
    parfor g = 1:max(max(wallY))
        Nos_ondes = Methode_image(Tx,Matrice_recepteur{a,g},Mur);
        [Mb(a,g),Sens(a,g)]  = Prx(Tx,Nos_ondes,h,Ra);
    end
end

%% Display.

% In order to display our walls without the waves. 

% x = 1:1:(max(max(wallX)));
% y = 1:1:(max(max(wallY)));
% [X,Y] = meshgrid(x,y);
% 
% plot(wallX,wallY,'b')%visualisation des murs
% text(Tx.position(1),Tx.position(2),'TX','Color','b') % Mettre un point dans le futur.
% text(Rx.position(1),Rx.position(2),'RX','Color','b') % Mettre un point dans le futur.

x = 0:1:(max(max(wallX)));
y = 0:1:(max(max(wallY)));
[X,Y] = meshgrid(x,y);

%contour(X,Y,Mb)

% adding color map and showing it on the screen.

%ax1 = subplot(1,1,1);

figure

contourf(X,Y,Mb',150,'LineColor','none')
title('Débit binaire [Mb/s]')
set(gca, 'DataAspectRatio', [1 1 1])
colormap(jet);
caxis([40 320])
c = colorbar;
c.Label.String = 'Mb/s';
hold on 
plot(wallX,wallY,'w')
%text(Tx.position(1),Tx.position(2),'TX','Color','w') % Mettre un point dans le futur.
%title('Puissance Recue Dans le MET, Station de base(100.65) : Ray Tracing avec 5G 27GHz')
% text(Rx.position(1),Rx.position(2),"RX",'Color','w') % Mettre un point dans le futur.
axis([0 200 0 200])
set(gca,'color','k')
set(gcf,'color','w')
scatter(100,55,5,'fill')

figure

contourf(X,Y,Sens',150,'LineColor','none')
title('Sensibilité [dBm]')
set(gca, 'DataAspectRatio', [1 1 1])
colormap(hot);
caxis([-82 -73])
c = colorbar;
c.Label.String = 'dBm';
hold on
plot(wallX,wallY,'w')
%text(Tx.position(1),Tx.position(2),'TX','Color','w') % Mettre un point dans le futur.
%title('Puissance Recue Dans le MET, Station de base(100.65) : Ray Tracing avec 5G 27GHz')
% text(Rx.position(1),Rx.position(2),"RX",'Color','w') % Mettre un point dans le futur.
axis([0 200 0 200])
set(gca,'color','k')
set(gcf,'color','w')
scatter(100,55,5,'fill')

toc