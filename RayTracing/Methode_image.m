function [Nos_ondes] = Methode_image(Tx,Rx,Mur)

% Vector method. (For image method).
% Returns the coordinates of P.
% Returns the incident angle and the distance between TXprime and RX.
% for i=1:length(wall.debut) Repeat for all subsequent walls.
% Calculates wall slope and y-intercept

%% Initialisation

% For our direct wave.

d_directe = norm(Rx.position - Tx.position); % Distance.
Onde_directe = Wave(d_directe);
for z = 1:length(Mur)
    obj = Mur{z};
    Onde_directe = Impact_transmission(Onde_directe,obj,Tx.position,Rx.position);
end
Nos_ondes{1} = Onde_directe;% Storing our waves. Object matrix for waves.

%% Image method.

% 1st reflection.

for i = 1:length(Mur)
    obj_mur = Mur{i};
    [Tx_image,Impact,P_1,theta_i,distance] = Methode_de_Cramer(Tx.position,Rx.position,obj_mur);
    %Tx_image;
    if (Impact == 1) % Impact of Cramer's method. Impact of 1st reflection.
        Onde = Wave(distance);
        for z = 1:length(Mur) % Look at all the collisions between the base station and the imapct point for reflection.
            obj = Mur{z};
            Onde = Impact_transmission(Onde,obj,Tx.position,P_1);
            Onde = Impact_transmission(Onde,obj,P_1,Rx.position);
        end
        Ref = Coeff_Reflex(obj_mur,theta_i);
        % Trans = Coeff_Trans(obj_mur,theta_i);
        Onde = Modif_Reflexion(Onde,Ref); % Modifie le coeff. de reflexion
        Onde = Indice_reflexion(Onde); 
        % Onde = Modif_Transmission(Onde,Trans); % Modifie le coeff. de transmission
%         if (dessin==1)
%             hold on
%             l1 = line([Tx.position(1) P_1(1) Rx.position(1)],[Tx.position(2) P_1(2) Rx.position(2)]); % Tracer du rayon.
%             set(l1,'color','b')
%         end
        Nos_ondes{end+1} = Onde;
    end 

% second reflection.

    Mur_2 = Mur;
    Mur_2(i) = []; % At the end, the element must be returned to its cell.
    for j = 1:length(Mur_2)
        obj_mur2 = Mur_2{j};
        [Tx_image2,Impact2,P_2_2,theta_i2,distance] = Methode_de_Cramer(Tx_image,Rx.position,obj_mur2);
        if (Impact2 == 1)
            [Tx_im,Impact3,P_2_1,theta_i1,dist_Tx_P2] = Methode_de_Cramer(Tx.position,P_2_2,obj_mur);
            if (Impact3 == 1)
                Onde = Wave(distance);
                for z = 1:length(Mur) % Look at all the collisions between the base station and the imapct point for reflection.
                    obj = Mur{z};
                    Onde = Impact_transmission(Onde,obj,Tx.position,P_2_1);
                    Onde = Impact_transmission(Onde,obj,P_2_1,P_2_2);
                    Onde = Impact_transmission(Onde,obj,P_2_2,Rx.position);
                end
                Ref = Coeff_Reflex(obj_mur2,theta_i2)*Coeff_Reflex(obj_mur,theta_i1);
                % Trans = Coeff_Trans(obj_mur2,theta_i2)*Coeff_Trans(obj_mur,theta_i1);
                Onde = Modif_Reflexion(Onde,Ref); % Modifie le coeff. de reflexion
                Onde = Indice_reflexion(Onde); 
                % Onde = Modif_Transmission(Onde,Trans); % Modifie le coeff. de transmission
%                 if (dessin==1)
%                     hold on
%                     l2 = line([Tx.position(1) P_2_1(1) P_2_2(1) Rx.position(1)],[Tx.position(2) P_2_1(2) P_2_2(2) Rx.position(2)]); % Tracer du rayon.
%                     set(l2,'color','r')
%                 end
                Nos_ondes{end+1} = Onde;
            end
        end

        % third reflection. 
        
%         Mur_3 = Mur;
%         Mur_3(i) = [];
%         Mur_3(j) = [];
%         for k = 1:length(Mur_3)
%             obj_mur3 = Mur_3{k};
%             [Tx_image3,Impact3,P_3_3,theta_i3,distance] = Methode_de_Cramer(Tx_image2,Rx.position,obj_mur3);
%             if (Impact3 == 1)
%                 [Tx_image2,Impact2,P_3_2,theta_i2,dist_TxIm_P_3_3] = Methode_de_Cramer(Tx_image,P_3_3,obj_mur2);
%                 if (Impact2 == 1)
%                     [Tx_im,Impact1,P_3_1,theta_i1,dist_Tx_P_3_2] = Methode_de_Cramer(Tx.position,P_3_2,obj_mur);
%                     if (Impact1 == 1)
%                         Onde = Wave(distance);
%                         for z = 1:length(Mur) % Regarde toutes les collisions entre la station de base et le point d'imapct pour la réflexion.
%                             obj = Mur{z};
%                             Onde = Impact_transmission(Onde,obj,Tx.position,P_3_1);
%                             Onde = Impact_transmission(Onde,obj,P_3_1,P_3_2);
%                             Onde = Impact_transmission(Onde,obj,P_3_2,P_3_3);
%                             Onde = Impact_transmission(Onde,obj,P_3_3,Rx.position);
%                         end
%                         Ref = Coeff_Reflex(obj_mur3,theta_i3)*Coeff_Reflex(obj_mur2,theta_i2)*Coeff_Reflex(obj_mur,theta_i1);
%                         Trans = Coeff_Trans(obj_mur3,theta_i3)*Coeff_Trans(obj_mur2,theta_i2)*Coeff_Trans(obj_mur,theta_i1);
%                         Onde = Modif_Reflexion(Onde,Ref); % Modifie le coeff. de reflexion
%                         Onde = Indice_reflexion(Onde); 
%                         Onde = Modif_Transmission(Onde,Trans); % Modifie le coeff. de transmission
% %                         if (dessin==1)
% %                             hold on
% %                             l3 = line([Tx.position(1) P_3_1(1) P_3_2(1) P_3_3(1) Rx.position(1)],[Tx.position(2) P_3_1(2) P_3_2(2) P_3_3(2) Rx.position(2)]); % Tracer du rayon.
% %                             set(l3,'color','y')
% %                         end
%                         Nos_ondes{end+1} = Onde; 
%                     end
%                 end
%             end
    end
end
end   