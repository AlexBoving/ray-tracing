classdef Base
    %BASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position
        gain
        puissance_emmission
    end
    
    methods
        function obj = Base(position)
            %BASE Construct an instance of this class
            %   Detailed explanation goes here
            obj.position = position;
            obj.gain = 1.7; % See the technical specifications pdf.
            obj.puissance_emmission = 10^(20/10-3); % See the technical specifications pdf.
        end
    end
end

