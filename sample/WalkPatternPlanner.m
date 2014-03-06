function [Body, HoldFoot, MoveFoot] = WalkPatternPlanner(stepsize,t,Tc,lefthold)

    % robot param
    Lan = 0.05;
    Lab = 0.05;
    Laf = 0.11;

    % time param
    k = floor(t / Tc);
    Td = 0.2 * Tc;
    Tm = 0.5 * Tc;

    % walking param
    mDs3D = stepsize(1:2);
    TurnAngle = stepsize(3);
    Ds = Length(mDs3D(1:2)');

    % swing foot param
    Qb = 0.2;
    Lao = 0.5 * Ds; % hold foot hight point x
    Hao = 0.14; % hold foot hight point z

    % holding foot pram
    Qf = 0.2;

    % hip param
    Hhmin = 0.23;
    Hhmax = 0.23;

    Xed = 0.72 * mDs3D(2);
    Xsd = 0.3 * mDs3D(2);

    t_foot_angle = [k*Tc, k*Tc+Td, (k+1)*Tc, (k+1)*Tc+Td];
    theta_a =      [0   , Qb     ,  -Qf    , 0];

    t_foot_pos = [k*Tc, k*Tc+Td                          , k*Tc+Tm , (k+1)*Tc                            , (k+1)*Tc+Td];
    x_a =        [k*Ds, k*Ds+Lan*sin(Qb)+ Laf*(1-cos(Qb)), k*Ds+Lao, (k+2)*Ds-Lan*sin(Qf)-Lab*(1-cos(Qf)), (k+2)*Ds];
    z_a =        [Lan , Laf*sin(Qb)+Lan*cos(Qb)          , Hao     , Lab*sin(Qf)+Lan*cos(Qf)             , Lan];

    t_hip_height = [k*Tc+0.5*Td, k*Tc+0.5*(Tc-Td), (k+1)*Tc+0.5*Td];
    z_h =          [Hhmin      , Hhmax           , Hhmin];

    t_hip_x = [k*Tc    , k*Tc+Td     , (k+1)*Tc];
    x_h =     [k*Ds+Xed, (k+1)*Ds-Xsd, (k+1)*Ds+Xed];


    mHipMatrix = eye(4);
    mHoldAnkleMatrix = eye(4);
    mMoveAnkleMatrix = eye(4);
    
    % hip x
    
    if t < (k+1) * Tc
        hx = GetHipX(t,Tc,Td,Ds,Xsd,Xed,k);
    else
        hx = GetHipX(t-Tc,Tc,Td,Ds,Xsd,Xed,k) + Ds;
    end
    
    % hip height
    hz = Hhmax;
    
    % move foot
    if t < (k+1) * Tc + Td
        fx1 = Spline(t_foot_pos,x_a,t);
        fz1 = Spline(t_foot_pos,z_a,t);
    else
        fx1 = (k+2) * Ds;
        fz1 = Lan;
    end
    
    % hold foot
    if t < k * Tc + Td
        fx2 = Spline(t_foot_pos,x_a,t+Tc) - Ds;
        fz2 = Spline(t_foot_pos,z_a,t+Tc);
    elseif t < (k+1) * Tc
        fx2 = (k+1)*Ds;
        fz2 = Lan;
    else
        fx2 = (k+1)*Ds;
        fz2 = Lan;
    end

    hip_pos = hx / Ds .* mDs3D;
    hip_pos(3) = hz;
    mHipMatrix(1:3,4) = hip_pos;
    
    holdanke_pos = fx2 / Ds .* mDs3D;
    holdanke_pos(3) = fz2;
    mHoldAnkleMatrix(1:3,4) = holdanke_pos;
    
    moveankle_pos = fx1 / Ds .* mDs3D;
    moveankle_pos(3) = fz1;
    mMoveAnkleMatrix(1:3,4) = moveankle_pos;
    
    mHipMatrix(3,4) = mHipMatrix(3,4) + 0.115;
    mHipMatrix(2,4) = mHipMatrix(2,4) + 0.01;
    mHipMatrix = mHipMatrix * Rx(-10);
    
    if lefthold
        mMoveAnkleMatrix(1,4) = mMoveAnkleMatrix(1,4) + 0.055;
        mHoldAnkleMatrix(1,4) = mHoldAnkleMatrix(1,4) - 0.055;
    else
        mMoveAnkleMatrix(1,4) = mMoveAnkleMatrix(1,4) - 0.055;
        mHoldAnkleMatrix(1,4) = mHoldAnkleMatrix(1,4) + 0.055;
    end
    
    Body = mHipMatrix;
    HoldFoot = mHoldAnkleMatrix;
    MoveFoot = mMoveAnkleMatrix;

end