classdef Wall
    %MUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        debut
        fin
        perm_relative
        conductivite
        Z_2
    end
    
    methods
        function obj = Wall(debut,fin,perm_relative,conductivite,Z_0,w,ep0) 
            %MUR Construct an instance of this class
            %   Detailed explanation goes here
            obj.debut = debut;
            obj.fin = fin;
            obj.perm_relative = perm_relative;
            obj.conductivite = conductivite;
            e_c_r = perm_relative - 1i*conductivite/(w*ep0); % epsilon complexe 
            obj.Z_2 = Z_0/sqrt(e_c_r); % Impédance du mur. 
        end
    end
end

