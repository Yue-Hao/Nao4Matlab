%% ???
clear all;
clc
clf


Nao;

global uLINK
global Torso Neck Head
global RShoulder LShoulder RUpperarm LUpperarm RElbow LElbow RLowerarm LLowerarm
global RHip1 LHip1 RHip2 LHip2 RThigh LThigh RShank LShank RAnkle LAnkle RFoot LFoot

% initialize
lefthold = 0;
n = 0;   % current step
step_done = 0;
cycle = 1;
Tc = 0.11;
z = 0.345;
hip_width = 0.11;

HoldFoot.R = eye(3);
HoldFoot.p = [0.055,0,0.05]';
CoMStart = [0.0,0.01]';
dCoMStart = [0,0]';

MoveFootStart.R = eye(3);
MoveFootStart.p = [-0.055,0,0.05]';

CoMEnd = [0,0]';
dCoMEnd = [0,0]';
MoveFootEnd.R = eye(3);
MoveFootEnd.p = [-0.055,0,0.05]';


S = [0,0.02,0;
     0,0.06,0;
     0,0.10,0;
     0.02,0.14,0;
     0.04,0.16,-10;
     0.08,0.16,-10;
     0.10,0.16,-10;
     0.10,0.16,-10;
     0,0.16,0;
     0,0.16,0;
     0,0.16,0;
     0,0.16,0;
     0,0.16,0;];

 S = [0 0.0 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0;
      0 0.01 0];
 
 skip_frame = 5;

%%
for t = 0 : 0.02 : 1.32
    
    
    % current step
    n = floor(t / Tc) + 1;
    
    if n > size(S,1)
        break;
    end
    
    tinTc = t - (n-1)*Tc;
    
    % new step start, plan step
    if n > step_done
        n
        step_done = step_done + 1;
        
        s = [0,0,0];
        % start step
        if n == 1
            if lefthold
                s = [hip_width,0,0];
            else
                s = [-hip_width,0,0];
            end
        else
            lefthold = ~lefthold;
      
            s = ns;
            
            MoveFootStart = HoldFoot;
            HoldFoot = MoveFootEnd;
            CoMStart = CoMEnd;
            dCoMStart = dCoMEnd;
        end
        
        ns = S(n,:)';
        
        if ~lefthold
            ns = [hip_width + ns(1)/2,ns(2)/2,ns(3)]';
        else
            ns = [-hip_width + ns(1)/2,ns(2)/2,ns(3)]';
        end
        
        [CoMEnd,dCoMEnd,Rs,Ps] = LIP3DWalk(s,ns,HoldFoot.R(1:2,1:2),HoldFoot.p(1:2),...
                                   CoMStart,dCoMStart,Tc,z-0.05);
        
        MoveFootEnd.R(1:2,1:2) = Rs;
        MoveFootEnd.p(1:2) = Ps;
        
        CoMEnd
        dCoMEnd
        %Rs
        %Ps
    end
    
    tinTc
    CoM = LIP3D(HoldFoot.p(1:2),CoMStart,dCoMStart,tinTc,z-0.05);
    [Body, MoveFoot] = LIP3DWalkPatternPlanner(MoveFootStart,MoveFootEnd,...
                                                CoMStart,dCoMStart,s(3),...
                                                HoldFoot,z,tinTc,Tc,lefthold);
    HoldFoott = eye(4);
    HoldFoott(1:3,1:3) = HoldFoot.R;
    HoldFoott(1:3,4) = HoldFoot.p;
    Body
    MoveFoot
    HoldFoott
    lefthold
    MoveFoot = MakeStruct(MoveFoot);
    Body = MakeStruct(Body);

    hhhhhhh(:,cycle) = MoveFoot.p - HoldFoot.p;
    % compute ik
    uLINK(Torso).R = Body.R;
    uLINK(Torso).p = Body.p;
    %continue;
    
    
    if lefthold
        InverseKinematics(LFoot, HoldFoot);
        InverseKinematics(RFoot, MoveFoot);
    else
        InverseKinematics(RFoot, HoldFoot);
        InverseKinematics(LFoot, MoveFoot);
    end
    
    12
    deg2rad(uLINK(12).q)
    14
    deg2rad(uLINK(14).q)
    16
    deg2rad(uLINK(16).q)
    18
    deg2rad(uLINK(18).q)
    20
    deg2rad(uLINK(20).q)
    22
    deg2rad(uLINK(22).q)
    
    13
    deg2rad(uLINK(13).q)
    15
    deg2rad(uLINK(15).q)
    17
    deg2rad(uLINK(17).q)
    19
    deg2rad(uLINK(19).q)
    21
    deg2rad(uLINK(21).q)
    23
    deg2rad(uLINK(23).q)
    
    
    continue;
    
    % render
    ForwardKinematics(Torso);
    newplot
    if(mod(cycle,skip_frame) == 1)
        PlotSkeleton(Torso);
    end
    hold on
    
    axis([-0.35 0.35 -0.1 0.9 0 0.7]);
    
    hold_foot(cycle,:) = HoldFoot.p';
    plot3(hold_foot(:,1),hold_foot(:,2),hold_foot(:,3),'k.','MarkerSize',20)
    traj_x(cycle,:) = [Body.p(1),MoveFoot.p(1)];
    traj_y(cycle,:) = [Body.p(2),MoveFoot.p(2)];
    traj_z(cycle,:) = [Body.p(3),MoveFoot.p(3)];
    plot3(traj_x,traj_y,traj_z);
    
    plot3(HoldFoot.p(1),HoldFoot.p(2),HoldFoot.p(3),'k.','MarkerSize',20);
    plot3(MoveFootStart.p(1),MoveFootStart.p(2),MoveFootStart.p(3),'g.','MarkerSize',20);
    plot3(MoveFootEnd.p(1),MoveFootEnd.p(2),MoveFootEnd.p(3),'r.','MarkerSize',20);
%  %plot3(MoveFoot.p(1),MoveFoot.p(2),MoveFoot.p(3),'r.');
    plot3(CoMStart(1),CoMStart(2),z,'b.','MarkerSize',20);
    plot3(CoMEnd(1),CoMEnd(2),z,'b.','MarkerSize',20);
%  %plot3(Body.p(1),Body.p(2),Body.p(3),'g.');

    
    xlabel('x')
    ylabel('y')
    zlabel('y')
    view([135 20]);
    %view([90 90]);
    title(['SimTime ' num2str(t)]);
    set(gcf,'Position',[100,100,1250,800])
    set(gcf,'paperpositionmode','auto')
    %hold off
    drawnow
    
    %pause;
    % finish sim
    
    cycle = cycle + 1;
end
max(abs(hhhhhhh(1,:)))