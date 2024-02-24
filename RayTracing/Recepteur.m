classdef Recepteur
    %RECEPTEUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position
        gain
        puissance_emmission
    end
    
    methods
        function obj = Recepteur(position)
            %RECEPTEUR Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.gain = 1.7;
            obj.puissance_emmission = 10^(20/10-3); 
        end
    end
end

