classdef Wave
    %WAVE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        d % Distance travelled by the wave.
        Gamma % Wave reflection coefficient. 
        T % Transmission coefficient.
        I_t % Transmission index. Takes into account the number of transmissions already made.
        I_r % Reflection index. Takes into account the number of reflections already performed.
    end
    
    methods
        function obj = Wave(d)
            %ONDE Construct an instance of this class
            %   Detailed explanation goes here
            obj.d = d;
            obj.Gamma = 1; % Initialize reflection and transmission coefficients
            obj.T = 1; % to 1 to indicate that the wave has not yet impacted a wall.
            obj.I_t = 0;
            obj.I_r = 0;
        end
        
        function obj = Indice_transmission(obj)
            %METHOD1 Summary of this method goes here
            % Returns the transmission index incremented by 1.
            obj.I_t = obj.I_t + 1;
        end
        
        function obj = Indice_reflexion(obj)
            %METHOD1 Summary of this method goes here
            % Returns the reflection index incremented by 1.
            obj.I_r = obj.I_r + 1;
        end
        
        function obj = Modif_Reflexion(obj,Ref)
            %METHOD1 Summary of this method goes here.
            obj.Gamma = obj.Gamma*Ref;
        end
        
        function obj = Modif_Transmission(obj,Trans)
            %METHOD1 Summary of this method goes here.
            obj.T = obj.T*Trans;
        end
    end
end

