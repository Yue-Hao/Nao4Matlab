% by Hao Yue % Nov,21,2012
%% initialization

%% create Nao
clear all;
clc;
clf;
Nao();
global uLINK
global Torso Neck Head
global RShoulder LShoulder RUpperarm LUpperarm RElbow LElbow RLowerarm LLowerarm
global RHip1 LHip1 RHip2 LHip2 RThigh LThigh RShank LShank RAnkle LAnkle RFoot LFoot

%uLINK(RThigh).q = -20;
%uLINK(Torso).p = [0,0,0]';
ForwardKinematics(Torso);
PlotRobot(Torso);
%%
com = calcCoM()

%%
Tc = 20;
time = 0:Tc;
t = [0,0.5*Tc,Tc];

init_pos = uLINK(RFoot).p;

theta = [0,-30, -90];
x = init_pos(1) + [0,0,0];
y = init_pos(2) + [0,-0.08,-0.12];
z = init_pos(3) + [0.0,0.05,0.15];
traj_theta = spline(t,theta,time);
traj_x = spline(t,x,time);
traj_y = spline(t,y,time);
traj_z = spline(t,z,time);

plot(traj_y,traj_z)

%% 
for i = 1:length(time)
    figure(1);

    Nao();
    T = Trans([traj_x(i),traj_y(i),traj_z(i)]') * Rx(traj_theta(i))
    RFootTarget.R = T(1:3,1:3);
    RFootTarget.p = T(1:3,4);
    
    uLINK(RFoot).child = 0;
    %InverseKinematics(RFoot, RFootTarget);
    
    newplot
    PlotRobot(Torso);
    
    %hold on
    
    axis([-0.2 0.2 -0.2 0.2 0 0.7]);
    
    xlabel('x')
    ylabel('y')
    zlabel('y')
    view([130 10]);
    title(['SimTime ' num2str(time(i))]);
    set(gcf,'Position',[100,100,500,800])
    set(gcf,'paperpositionmode','auto')
    drawnow
    print(gcf,'-depsc','6.eps')
    break;
    
    figure(2)
    newplot
    hold on
    plot(traj_y,traj_z);
    plot(RFootTarget.p(2),RFootTarget.p(3),'r.','MarkerSize',20);
    drawnow
    pause(0.02)
end

%%
newplot

%[vert face] = MakeCylinder([1,2,3],1,3);

[vert face] = MakeBox([1,2,3],[1 2 3]);

%[vert face] = MakeSphere([1 2 3],2);

h = patch('faces',face,'vertices',vert','FaceColor',[0.5 0.5 0.5]);
axis equal; view(3);grid on;%xlim(AX);ylim(AX);ylim(AY);zlim(AZ);

drawnow

%%
syms x y z o 
w_mod = 1;
E = eye(3);
w = [x y z]
w = w / w_mod;
a = [ 0 -w(3) w(2);
     w(3) 0  -w(1);
     -w(2) w(1) 0;];
e = E + a * sin(w_mod*o) + a^2 * (1-cos(w_mod*o))

%%
P_init = [0,0]';
X_init = [0.15,0.10]';
dX_init = [-0.1,-0.1]';

i = 1;
for t = 0:0.001:0.11
    Xf = LIP3D(P_init,X_init,dX_init,t)
    X(:,i) = Xf;
    i = i+1;
end
plot(X(1,:),X(2,:));