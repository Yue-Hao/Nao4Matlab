function [Body, MoveFoot] = LIP3DWalkPatternPlanner(MoveFootStart,MoveFootEnd,...
                                                    CoMStart,dCoMStart,theta,...
                                                    HoldFoot,z,t,Tc,lefthold)

    %t
    % robot param
    Lan = 0.05;
    Lab = 0.05;
    Laf = 0.11;

    % time param
    Td = 0.2 * Tc;
    Tm = 0.5 * Tc;

    % swing foot param
    Qb = 0.2;
    Hao = 0.14; % hold foot hight point z

    % holding foot pram
    Qf = 0.2;
    
    CoMm = LIP3D(HoldFoot.p(1:2),CoMStart,dCoMStart,Tm,z-0.05);
    
    
    %t_foot_angle = [k*Tc, k*Tc+Td, (k+1)*Tc, (k+1)*Tc+Td];
    %theta_a =      [0   , Qb     ,  -Qf    , 0];

    t_move_z = [0                 , Tm , Tc ];
    move_z   = [Lan               , Hao, Lan];
    
    t_move_x =     [0                 , Tm          , Tc];
    if lefthold
        move_x   = [MoveFootStart.p(1), CoMm(1)+0.055, MoveFootEnd.p(1)];
    else
        move_x   = [MoveFootStart.p(1), CoMm(1)-0.055, MoveFootEnd.p(1)];
    end

    t_move_y = [0                 , Tm     , Tc];
    move_y   = [MoveFootStart.p(2), CoMm(2), MoveFootEnd.p(2)];
 
    turn_angle = theta * t / Tc;
    
    %body pos
    CoM = LIP3D(HoldFoot.p(1:2),CoMStart,dCoMStart,t,z-0.05);
    
    %HoldFoot_ = HoldFoot.R
    %turn_angle
    
    Body = eye(4);
    Body(1:3,1:3) = HoldFoot.R;
    Body = Body * Rz(turn_angle);
    Body = Body * Rx(-10);
    Body(1:3,4) = [CoM;z];

    %move foot theta
    mfy = Spline(t_move_y,move_y,t);
    mfx = Spline(t_move_x,move_x,t);
    mfz = Spline(t_move_z,move_z,t);
    
    MoveFoot = eye(4);
    MoveFoot(1:3,1:3) = MoveFootStart.R;
    MoveFoot = MoveFoot * Rz(turn_angle);
    MoveFoot(1:3,4) = [mfx,mfy,mfz]';
    

end