% by Hao Yue % Nov,21,2012
%%

clear all
clc

%set the kick trajectory
   
    
    % phase time
    Ts=0;
    Tsa=0.001;
    Tab=0.001;
    Tbc=0.001;
    Tcd=0.0005;
    Tde=0.0003;
    Tef=0.001;
    Tfg=0.001;
    
    % horizontal coordinate of ankle
    Xs=0;
    Xa=-0.0914;
    Xb=-0.13;
    Xc=0.0187;  %lowest point
    Xd=0.1;        %ball point
    Xe=0.12;
    Xf=0.07;
    Xg=0;
    
    % vertical coordinate of ankle
    Zs=0.055;
    Za=0.0952; 
    Zb=0.20;
    Zc=0.0588;  %lowest point
    Zd=0.08;
    Ze=0.1015;
    Zf=0.0657;
    Zg=0.055;
    
    % inclination of the foot
    Qs=0;
    Qa=-25;
    Qb=-120;
    Qc=0;
    Qd=10;
    Qe=40;
    Qf=30;
    Qg=0;
  
    
    T=Tsa+Tab+Tbc+Tcd+Tde+Tef+Tfg;
    time=0:0.0001:T;
    
    StartTrajX=zeros(length(time));
    StartTrajZ=zeros(length(time));
    StartTrajQ=zeros(length(time));
    
    NormalTrajX=zeros(length(time));
    NormalTrajZ=zeros(length(time));
    NormalTrajQ=zeros(length(time));
    
    EndTrajX=zeros(length(time));
    EndTrajZ=zeros(length(time));
    EndTrajQ=zeros(length(time));
    
    TrajX=zeros(size(time))';
    TrajZ=zeros(size(time))';
    TrajQ=zeros(size(time))';

    for i = 1:length(time)
        
        t = time(i);
        
    

        % start phase
        if t<(Tsa+Tab)
            StartPointsX=[Xs,Xa,Xb];
            StartPointsZ=[Zs,Za,Zb];
            StartPointsQ=[Qs,Qa,Qb];
            StartTrajX(i)=spline([0,Tsa,Tsa+Tab],StartPointsX,t);
            StartTrajZ(i)=spline([0,Tsa,Tsa+Tab],StartPointsZ,t);
            StartTrajQ(i)=spline([0,Tsa,Tsa+Tab],StartPointsQ,t);
        end 

        %normal phase
        if t>=(Tsa+Tab)&&t<(Tsa+Tab+Tbc+Tcd+Tde)
            NormalPointsX=[Xb,Xc,Xd,Xe];
            NormalPointsZ=[Zb,Zc,Zd,Ze];
            NormalPointsQ=[Qb,Qc,Qd,Qe];
            NormalTrajX(i)=spline([Tsa+Tab,Tsa+Tab+Tbc,Tsa+Tab+Tbc+Tcd,Tsa+Tab+Tbc+Tcd+Tde],NormalPointsX,t);
            NormalTrajZ(i)=spline([Tsa+Tab,Tsa+Tab+Tbc,Tsa+Tab+Tbc+Tcd,Tsa+Tab+Tbc+Tcd+Tde],NormalPointsZ,t);
            NormalTrajQ(i)=spline([Tsa+Tab,Tsa+Tab+Tbc,Tsa+Tab+Tbc+Tcd,Tsa+Tab+Tbc+Tcd+Tde],NormalPointsQ,t);
        end

        %end phase
        if t>=(Tsa+Tab+Tbc+Tcd+Tde)
            EndPointsX=[Xe,Xf,Xg];
            EndPointsZ=[Ze,Zf,Zg];
            EndPointsQ=[Qe,Qf,Qg];
            EndTrajX(i)=spline([Tsa+Tab+Tbc+Tcd+Tde,Tsa+Tab+Tbc+Tcd+Tde+Tef,T],EndPointsX,t);
            EndTrajZ(i)=spline([Tsa+Tab+Tbc+Tcd+Tde,Tsa+Tab+Tbc+Tcd+Tde+Tef,T],EndPointsZ,t);
            EndTrajQ(i)=spline([Tsa+Tab+Tbc+Tcd+Tde,Tsa+Tab+Tbc+Tcd+Tde+Tef,T] ,EndPointsQ,t);
        end

        TrajX(i)=StartTrajX(i)+NormalTrajX(i)+EndTrajX(i);
        TrajZ(i)=StartTrajZ(i)+NormalTrajZ(i)+EndTrajZ(i);
        TrajQ(i)=StartTrajQ(i)+NormalTrajQ(i)+EndTrajQ(i);
 
       
    end
    
    axis([-0.2 0.3 0 0.35])
    set(gca,'XTick',-0.2:0.05:0.3);
    set(gca,'YTick',0:0.05:0.35);
    plot(TrajX,TrajZ);
    %plot(0.01 * cos(deg2rad(TrajQ)),0.01 * sin(deg2rad(TrajQ)))
    line([TrajX,  TrajX + 0.01 * cos(deg2rad(TrajQ))]',[TrajZ, TrajZ + 0.01 * sin(deg2rad(TrajQ))]');
    
    hold on
    plot([Xs],[Zs],'m.','MarkerSize',20);
    plot([Xa],[Za],'y.','MarkerSize',20);
    plot([Xb],[Zb],'b.','MarkerSize',20);
    plot([Xc],[Zc],'g.','MarkerSize',20);
    plot([Xd],[Zd],'c.','MarkerSize',20);
    plot([Xe],[Ze],'k.','MarkerSize',20);
    plot([Xf],[Zf],'k.','MarkerSize',20);
    
    offset=0.01;
    text([Xs],[Zs]+offset,'s');
    text([Xa],[Za]+offset,'a');
    text([Xb],[Zb]+offset,'b');
    text([Xc],[Zc]+offset,'c');
    text([Xd],[Zd]+offset,'d');
    text([Xe],[Ze]+offset,'e');
    text([Xf],[Zf]+offset,'f');
    

%%
Nao();
global uLINK
global Torso Neck Head
global RShoulder LShoulder RUpperarm LUpperarm RElbow LElbow RLowerarm LLowerarm
global RHip1 LHip1 RHip2 LHip2 RThigh LThigh RShank LShank RAnkle LAnkle RFoot LFoot

%%
init_pos = uLINK(RFoot).p;

for i = 1:length(time)
    figure(1);
    newplot
    
    T = Trans([init_pos(1),TrajX(i,1),TrajZ(i,1)]') * Rx(TrajQ(i,1))
    RFootTarget.R = T(1:3,1:3);
    RFootTarget.p = T(1:3,4);

    InverseKinematics(RFoot, RFootTarget);
    PlotRobot(Torso);
    
    hold on
    
    axis([-0.2 0.2 -0.2 0.2 0 0.7]);
    
    xlabel('x')
    ylabel('y')
    zlabel('y')
    view([90 0]);
    title(['SimTime ' num2str(time(i))]);
    set(gcf,'Position',[100,100,500,800])
    set(gcf,'paperpositionmode','auto');
    drawnow
    
    %figure(2)
    %newplot
    %hold on
    %plot(traj_y,traj_z);
    %plot(RFootTarget.p(2),RFootTarget.p(3),'r.','MarkerSize',20);
    %drawnow
    pause(0.02)
end