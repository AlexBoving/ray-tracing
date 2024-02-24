function [Tx_image,Impact,P,theta_i,distance] = Methode_de_Cramer(Tx,Rx,obj)
% This function returns the coordinates of the image base station.
% Principle based on the vectorial method seen in TP with the assistant.
% Video Teams is the FAQ for the project.
% See if U and Proj_S should be removed.

if (obj.debut(1) == obj.fin(1)) % Case we have a vertical wall.
    if (Tx(1) > obj.debut(1)) && (Rx(1) > obj.debut(1))
        n = [1,0]; % vector normal to the wall.
        U = [obj.fin(1) - obj.debut(1),obj.fin(2) - obj.debut(2)]/(norm(obj.fin - obj.debut));
    elseif (Tx(1) <= obj.debut(1)) && (Rx(1) <= obj.debut(1))
        n = [-1,0];
        U = [obj.fin(1) - obj.debut(1),obj.fin(2) - obj.debut(2)]/(norm(obj.fin - obj.debut));
    else
        Tx_image = [2*obj.debut(1) - Tx(1),Tx(2)];
        U = NaN;
        Proj_S = NaN;
        Impact = 0;
        P = NaN;
        distance = NaN;
        theta_i = NaN;
        return
    end
elseif (obj.debut(2) == obj.fin(2)) % Case the wall is horizontal. 
    if (Tx(2) > obj.debut(2)) && (Rx(2) > obj.debut(2))
        n = [0,1]; % vector normal to the wall.
        U = [obj.fin(1) - obj.debut(1),obj.fin(2) - obj.debut(2)]/(norm(obj.fin - obj.debut));
        
    elseif (Tx(2) < obj.debut(2)) && (Rx(2) < obj.debut(2))
        n = [0,-1];
        U = [obj.fin(1) - obj.debut(1),obj.fin(2) - obj.debut(2)]/(norm(obj.fin - obj.debut));
    else
        Tx_image = [Tx(1),2*obj.debut(2) - Tx(2)];
        U = NaN;
        Proj_S = NaN;
        Impact = 0;
        P = NaN;
        distance = NaN;
        theta_i = NaN;
        return
    end
end

% Wall direction vector
% Vector between initial position of wall and Tx
% Projection vector between Tx and wall.

S = Tx - obj.debut;
Proj_S = 2*dot(S,n)*n; %Projection between Tx and Wall.
    
% vector between TX and the start of a wall.
   
Tx_image = Tx - Proj_S;

% This vector-based function returns whether there is a
% a point of impact and the point of impact.

da = Rx - Tx_image; % Vector between Txprime and Rx receiver.
distance = norm(da); % Norm of the da vector.

% Find the point of intersection between the wall and the radius from
% Tx.

t = -(da(2)*(obj.debut(1)-Tx_image(1))-da(1)*((obj.debut(2)-Tx_image(2))))/(da(2)*U(1) - da(1)*U(2));
L = norm(obj.fin - obj.debut); % Wall's length.

if (t > 0) && (t < L)
    P = obj.debut + t*U; % Intersection position between wall and Tx radius.
    Impact = 1;
    y = (norm(Proj_S)/2);
    x = sqrt(norm(P - Tx)^2 - y^2); % Pythagor.
    theta_i =  atan(x/y); % theta_i angle.
   
else
    Impact = 0;
    theta_i = 0;
    P = NaN;
end
end
