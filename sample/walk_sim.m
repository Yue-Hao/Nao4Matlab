%% ???
clear all;

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

HoldFoot.R = eye(3);
HoldFoot.p = [0.055,0,0.05]';
BodyStart.R = eye(3);
BodyStart.p = [0,0,0.345];
MoveFootStart.R = eye(3);
MoveFootStart.p = [-0.055,0,0.05]';
%%
for t = 0 : 0.02 : 0.72
    
    n = floor(t / Tc) + 1;
    sn = [0.11,0.08,0.0]'; %S(n,:)';
    
    % start step
    if n == 1
        if lefthold
            s = [0.11,0,0];
        else
            s = [-0.11,0,0];
        end
    end
    
    % new step start
    if n > step_done
        step_done = step_done + 1;
        if n ~=1
            lefthold = ~lefthold;
        end
    end
    
    [Body, HoldFoot, MoveFoot] = WalkPatternPlanner(stepsize,t,Tc,lefthold)

    % compute ik
    uLINK(Torso).R = Body(1:3,1:3);
    uLINK(Torso).p = Body(1:3,4);
    
    if lefthold
        InverseKinematics(LFoot, MakeStruct(HoldFoot));
        InverseKinematics(RFoot, MakeStruct(MoveFoot));
    else
        InverseKinematics(RFoot, MakeStruct(HoldFoot));
        InverseKinematics(LFoot, MakeStruct(MoveFoot));
    end
    
    % render
    ForwardKinematics(Torso);
    newplot
    PlotSkeleton(Torso);
    hold on
    
    %traj_x(cycle,:) = [mHipMatrix(1,4),mHoldAnkleMatrix(1,4),mMoveAnkleMatrix(1,4)];
    %traj_y(cycle,:) = [mHipMatrix(2,4),mHoldAnkleMatrix(2,4),mMoveAnkleMatrix(2,4)];
    %traj_z(cycle,:) = [mHipMatrix(3,4),mHoldAnkleMatrix(3,4),mMoveAnkleMatrix(3,4)];
    %plot3(traj_x,traj_y,traj_z);
    
    axis([-0.35 0.35 0 1.0 0 0.7]);
    
    xlabel('x')
    ylabel('y')
    zlabel('y')
    view([90 0]);
    title(['SimTime ' num2str(t)]);
    set(gcf,'Position',[100,100,1250,800])
    set(gcf,'paperpositionmode','auto')
    hold off
    drawnow
    
    %pause;
    % finish sim
    cycle = cycle + 1;
    
    
end