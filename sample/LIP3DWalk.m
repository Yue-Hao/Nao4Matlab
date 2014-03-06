%% ?????
% X ????
% dX ????
% z ??
% s ??
% sn ??????
% Tsup ????

function [Xs,dXs,Rs,Ps] = LIP3DWalk(s,ns,R,P,X,dX,Tsup,z)

    %s,ns,R,P,X,dX,Tsup,z
    
    g = 9.81; % gravity
    
    Tc = (z/g)^(0.5);
    C = cosh(Tsup/Tc);                                                                   
    S = sinh(Tsup/Tc);

    %P
    % compute where CoM should be after this step
    Xf = (X - P)*C  + Tc*dX*S + P;   %(4.52)
    dXf =(X - P)/Tc*S + dX*C;        %(4.53)
    %ddXf = g/z*(Xf-P);
    
    Xs = Xf;
    dXs = dXf;
    
    ang = deg2rad(s(3));

    R = R * [cos(ang) -sin(ang);
             sin(ang)  cos(ang)];
    
    Rs = R;
 
    %s
    %tmp_v3f = R * [s(1) s(2)]'
    % where moving foot should be put after this step
    Pnext = P + R * [s(1) s(2)]';   %(4.58)

    % calculate next 
    ang = deg2rad(ns(3));
    
    %R
    
    R = R * [cos(ang) -sin(ang);
             sin(ang)  cos(ang)];

    
    Xbar = [ns(1)/2 ns(2)/2]';  %(4.59)
    dXbar = R * [(C-1)/(Tc*S) * Xbar(1);  %(4.60)
                 (C+1)/(Tc*S) * Xbar(2)];

    %Xbar
    %dXbar
    
    Xd = Pnext + Xbar;  %(4.55)
    dXd = dXbar;
    
    %Xd
    %dXd
    
    % adjast current step
    a = 10;
    b = 1;
    D = a*(C-1)^2 + b*(S/Tc)^2;
    %N = (Xd - C*Xf - Tc*S*dXf)
    %M = (Tc*D)*(dXd - S/Tc*Xf - C*dXf)
    P = -a*(C-1)/D*(Xd - C*Xf - Tc*S*dXf) ...
        -b*S/(Tc*D)*(dXd - S/Tc*Xf - C*dXf);  %(4.57)

    %D
    %P
    % ????
    %     V0 = dXf;
    %     VT = V0;
    %     A0 = ddXf;
    %     AT = g/z*(Xf-P);
    %     Kt = [ 0 0 0 1;
    %          Td3 Td2 Td 1;
    %          0 0 1 0;
    %          3*Td2 2*Td 1 0];
    %     K = Kt \ [V0 VT A0 AT]';
    %     X = K(1,:)'*Td4/4 + K(2,:)'*Td3/3 + K(3,:)'*Td2/2 + K(4,:)'*Td + Xf
    
    Ps = P;                                                                                                                                                                        

end