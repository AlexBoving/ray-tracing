function [Collision,theta_i] = Intersect(obj,p1,p2)
% Returns 1 and the point of impact if there is an impact between the wall
% and the line segment from point1 to point2.
% otherwise 0. We use Cramer's method. 

% The direction vector for the wave.

V = (p2 - p1)/norm(p2 - p1);
W = (obj.fin - obj.debut)/norm(obj.fin - obj.debut);

PD = V(2)*W(1)-V(1)*W(2);

theta_i = 0;

if (PD == 0)
    Collision = 0;
elseif isfinite(V)
        t = -(V(2)*(obj.debut(1)-p1(1))-V(1)*(obj.debut(2)-p1(2)))/PD;
        L = norm(obj.fin - obj.debut); % Wall's length.
        if (t > 0) && (t < L)
            P_impact = obj.debut + t*W;
            if (norm(P_impact - p1) < norm(p2-p1)) && (norm(P_impact - p2) < norm(p2-p1))
                P_impact;
                Collision = 1;
                W_3d = [W(1) W(2) 0];
                V_3d = [V(1) V(2) 0];
                %theta_i = pi/2 - acos((V(1)*W(1) + V(2)*W(2))/(norm(V)*norm(W)))
                theta_i = pi/2 - atan2(norm(cross(W_3d,V_3d)),dot(W_3d,V_3d));
                %theta_i = 0; 
                %hold on 
                %scatter(P_impact(1),P_impact(2),300);
            else
                P_impact = 0;
                Collision = 0;
            end
        else 
            Collision = 0;
        end
else
    Collision = 0;
end
end