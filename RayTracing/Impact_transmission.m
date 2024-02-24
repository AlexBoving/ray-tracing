function Onde = Impact_transmission(Onde,obj,Txposition,Rxposition)
    [Collision,theta] = Intersect(obj,Txposition,Rxposition);  
    if (Collision == 1)
        trans = Coeff_Trans(obj,theta); % Calculates the coefficient's multiplying parameter.
        Onde = Modif_Transmission(Onde,trans); % Modifies the transmission coefficient
    end
end