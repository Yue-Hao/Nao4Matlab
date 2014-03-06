function Xf = LIP3D(P,X,dX,Tsup,z)
    
    g = 9.81; % ?????
    
    Tc = (z/g)^(0.5);
    C = cosh(Tsup/Tc);                                                                    
    S = sinh(Tsup/Tc);

    %  ?????????????X?dX
    Xf = (X - P)*C  + Tc*dX*S + P;   %(4.52)
    
end