% by Hao Yue % Nov,21,2012
%% Nao model
function Nao()
%% global definition
% links
global uLINK
global Torso Neck Head
global RShoulder LShoulder RUpperarm LUpperarm RElbow LElbow RLowerarm LLowerarm
global RHip1 LHip1 RHip2 LHip2 RThigh LThigh RShank LShank RAnkle LAnkle RFoot LFoot

Torso = 1;
Neck = 2;
Head = 3;

RShoulder = 4;
LShoulder = 5;
RUpperarm = 6;
LUpperarm = 7;
RElbow = 8;
LElbow = 9;
RLowerarm = 10;
LLowerarm = 11;

RHip1 = 12;
LHip1 = 13;
RHip2 = 14;
LHip2 = 15;
RThigh = 16;
LThigh = 17;
RShank = 18;
LShank = 19;
RAnkle = 20;
LAnkle = 21;
RFoot = 22;
LFoot = 23;

%% data from Aldebaran Nao document
TorsoInit = [0.0,0.0,0.385]';
    
%Masses of bodily segments (in kilograms)
TorsoMass = 1.2171; %torso
NeckMass = 0.05;
HeadMass = 0.35;
ShoulderMass = 0.07;
UpperArmMass = 0.15;
ElbowMass = 0.035;
LowerArmMass = 0.2;
Hip1Mass = 0.09;
Hip2Mass = 0.125;
ThighMass = 0.275;
ShankMass = 0.225;
AnkleMass = 0.125;
FootMass = 0.2;

%% helper
I = eye(3);

%% Torso
uLINK(Torso).name = 'Torso';
uLINK(Torso).mother = 0;
uLINK(Torso).sister = 0;
uLINK(Torso).child = Neck;
uLINK(Torso).R = eye(3);
uLINK(Torso).p = TorsoInit;
uLINK(Torso).m = TorsoMass; %mass
uLINK(Torso).c = [0,0,0]'; %center of mass
[uLINK(Torso).vertex, uLINK(Torso).face] = MakeBox(uLINK(Torso).c,[0.1,0.1,0.18]);
[uLINK(Torso).skeleton.vertex, uLINK(Torso).skeleton.face] = MakeBox(uLINK(Torso).c,[0.1,0.1,0.18]);

%% Neck
uLINK(Neck).name = 'Neck';
uLINK(Neck).mother = Torso;
uLINK(Neck).sister = RShoulder;
uLINK(Neck).child = Head;
uLINK(Neck).a = [0,0,1]';
uLINK(Neck).b = [0,0,0.09]';
uLINK(Neck).c = [0,0,0]';
uLINK(Neck).q = 0;
uLINK(Neck).m = NeckMass;
uLINK(Neck).min = -120;
uLINK(Neck).max = 120;
[uLINK(Neck).vertex, uLINK(Neck).face] = MakeCylinder(uLINK(Neck).c,0.015,0.08);

%% Head
uLINK(Head).name = 'Head';
uLINK(Head).mother = Neck;
uLINK(Head).sister = 0;
uLINK(Head).child = 0;
uLINK(Head).a = [1,0,0]';
uLINK(Head).b = [0,0,0.06]';
uLINK(Head).c = [0,0,0.005]';
uLINK(Head).q = 0;
uLINK(Head).m = HeadMass;
uLINK(Head).min = -45;
uLINK(Head).max = 45;
[uLINK(Head).vertex, uLINK(Head).face] = MakeSphere(uLINK(Head).c,0.065);

%% Right Arm
uLINK(RShoulder).name = 'RShoulder';
uLINK(RShoulder).mother = Torso;
uLINK(RShoulder).sister = LShoulder;
uLINK(RShoulder).child = RUpperarm;
uLINK(RShoulder).a = [1,0,0]';
uLINK(RShoulder).b = [0.098,0,0.075]';
uLINK(RShoulder).c = [0,0,0]';
uLINK(RShoulder).q = 0;
uLINK(RShoulder).m = ShoulderMass;
uLINK(RShoulder).min = -120;
uLINK(RShoulder).max = 120;
[uLINK(RShoulder).vertex, uLINK(RShoulder).face] = MakeSphere(uLINK(RShoulder).c,0.01);

uLINK(RUpperarm).name = 'RUpperarm';
uLINK(RUpperarm).mother = RShoulder;
uLINK(RUpperarm).sister = 0;
uLINK(RUpperarm).child = RElbow;
uLINK(RUpperarm).a = [0,0,1]';
uLINK(RUpperarm).b = [0,0,0]';
uLINK(RUpperarm).c = [0.01,0.02,0]';
uLINK(RUpperarm).q = 0;
uLINK(RUpperarm).m = UpperArmMass;
uLINK(RUpperarm).min = -95;
uLINK(RUpperarm).max = 1;
[uLINK(RUpperarm).vertex, uLINK(RUpperarm).face] = MakeBox(uLINK(RUpperarm).c,[0.07,0.08,0.06]);

uLINK(RElbow).name = 'RElbow';
uLINK(RElbow).mother = RUpperarm;
uLINK(RElbow).sister = 0;
uLINK(RElbow).child = RLowerarm;
uLINK(RElbow).a = [0,1,0]';
uLINK(RElbow).b = [0,0.09,0.009]';
uLINK(RElbow).c = [0,0,0]';
uLINK(RElbow).q = 0;
uLINK(RElbow).m = ElbowMass;
uLINK(RElbow).min = -120;
uLINK(RElbow).max = 120;
[uLINK(RElbow).vertex, uLINK(RElbow).face] = MakeSphere(uLINK(RElbow).c,0.01);

uLINK(RLowerarm).name = 'RLowerarm';
uLINK(RLowerarm).mother = RElbow;
uLINK(RLowerarm).sister = 0;
uLINK(RLowerarm).child = 0;
uLINK(RLowerarm).a = [0,0,1]';
uLINK(RLowerarm).b = [0,0,0]';
uLINK(RLowerarm).c = [0,0.05,0]';
uLINK(RLowerarm).q = 0;
uLINK(RLowerarm).m = LowerArmMass;
uLINK(RLowerarm).min = -1;
uLINK(RLowerarm).max = 90;
[uLINK(RLowerarm).vertex, uLINK(RLowerarm).face] = MakeBox(uLINK(RLowerarm).c,[0.05,0.11,0.05]);


%% Left Arm
uLINK(LShoulder).name = 'LShoulder';
uLINK(LShoulder).mother = Torso;
uLINK(LShoulder).sister = RHip1;
uLINK(LShoulder).child = LUpperarm;
uLINK(LShoulder).a = [1,0,0]';
uLINK(LShoulder).b = [-0.098,0,0.075]';
uLINK(LShoulder).c = [0,0,0]';
uLINK(LShoulder).q = 0;
uLINK(LShoulder).m = ShoulderMass;
uLINK(LShoulder).min = -120;
uLINK(LShoulder).max = 120;
[uLINK(LShoulder).vertex, uLINK(LShoulder).face] = MakeSphere(uLINK(LShoulder).c,0.01);

uLINK(LUpperarm).name = 'LUpperarm';
uLINK(LUpperarm).mother = LShoulder;
uLINK(LUpperarm).sister = 0;
uLINK(LUpperarm).child = LElbow;
uLINK(LUpperarm).a = [0,0,1]';
uLINK(LUpperarm).b = [0,0,0]';
uLINK(LUpperarm).c = [-0.01,0.02,0]';
uLINK(LUpperarm).q = 0;
uLINK(LUpperarm).m = UpperArmMass;
uLINK(LUpperarm).min = -1;
uLINK(LUpperarm).max = 95;
[uLINK(LUpperarm).vertex, uLINK(LUpperarm).face] = MakeBox(uLINK(LUpperarm).c,[0.07,0.08,0.06]);

uLINK(LElbow).name = 'LElbow';
uLINK(LElbow).mother = LUpperarm;
uLINK(LElbow).sister = 0;
uLINK(LElbow).child = LLowerarm;
uLINK(LElbow).a = [0,1,0]';
uLINK(LElbow).b = [0,0.09,0.009]';
uLINK(LElbow).c = [0,0,0]';
uLINK(LElbow).q = 0;
uLINK(LElbow).m = ElbowMass;
uLINK(LElbow).min = -120;
uLINK(LElbow).max = 120;
[uLINK(LElbow).vertex, uLINK(LElbow).face] = MakeSphere(uLINK(LElbow).c,0.01);

uLINK(LLowerarm).name = 'LLowerarm';
uLINK(LLowerarm).mother = LElbow;
uLINK(LLowerarm).sister = 0;
uLINK(LLowerarm).child = 0;
uLINK(LLowerarm).a = [0,0,1]';
uLINK(LLowerarm).b = [0,0,0]';
uLINK(LLowerarm).c = [0,0.05,0]';
uLINK(LLowerarm).q = 0;
uLINK(LLowerarm).m = LowerArmMass;
uLINK(LLowerarm).min = -90;
uLINK(LLowerarm).max = 1;
[uLINK(LLowerarm).vertex, uLINK(LLowerarm).face] = MakeBox(uLINK(LLowerarm).c,[0.05,0.11,0.05]);

%% Right Leg
uLINK(RHip1).name = 'RHip1';
uLINK(RHip1).mother = Torso;
uLINK(RHip1).sister = LHip1;
uLINK(RHip1).child = RHip2;
uLINK(RHip1).a = [-0.7071,0,0.7071]';
uLINK(RHip1).b = [0.055,-0.01,-0.115]';
uLINK(RHip1).c = [0,0,0]';
uLINK(RHip1).q = 0;
uLINK(RHip1).m = Hip1Mass;
uLINK(RHip1).min = -90;
uLINK(RHip1).max = 1;
[uLINK(RHip1).vertex, uLINK(RHip1).face] = MakeSphere(uLINK(RHip1).c,0.01);
[uLINK(RHip1).skeleton.vertex, uLINK(RHip1).skeleton.face] = MakeSphere(uLINK(RHip1).c,0.01);


uLINK(RHip2).name = 'RHip2';
uLINK(RHip2).mother = RHip1;
uLINK(RHip2).sister = 0;
uLINK(RHip2).child = RThigh;
uLINK(RHip2).a = [0,1,0]';
uLINK(RHip2).b = [0,0,0]';
uLINK(RHip2).c = [0,0,0]';
uLINK(RHip2).q = 0;
uLINK(RHip2).m = Hip2Mass;
uLINK(RHip2).min = -45;
uLINK(RHip2).max = 25;
[uLINK(RHip2).vertex, uLINK(RHip2).face] = MakeSphere(uLINK(RHip2).c,0.01);
[uLINK(RHip2).skeleton.vertex, uLINK(RHip2).skeleton.face] = MakeSphere(uLINK(RHip2).c,0.01);

uLINK(RThigh).name = 'RThigh';
uLINK(RThigh).mother = RHip2;
uLINK(RThigh).sister = 0;
uLINK(RThigh).child = RShank;
uLINK(RThigh).a = [1,0,0]';
uLINK(RThigh).b = [0,0,0]';
uLINK(RThigh).c = [0,0.01,-0.04]';
uLINK(RThigh).q = 0;
uLINK(RThigh).m = ThighMass;
uLINK(RThigh).min = -25;
uLINK(RThigh).max = 100;
[uLINK(RThigh).vertex, uLINK(RThigh).face] = MakeBox(uLINK(RThigh).c,[0.07,0.07,0.14]);
[uLINK(RThigh).skeleton.vertex, uLINK(RThigh).skeleton.face] = MakeBox(uLINK(RThigh).c,[0.005,0.005,0.14]);

uLINK(RShank).name = 'RShank';
uLINK(RShank).mother = RThigh;
uLINK(RShank).sister = 0;
uLINK(RShank).child = RAnkle;
uLINK(RShank).a = [1,0,0]';
uLINK(RShank).b = [0,0.005,-0.120]';
uLINK(RShank).c = [0,0.01,-0.045]';
uLINK(RShank).q = 0;
uLINK(RShank).m = ShankMass;
uLINK(RShank).min = -130;
uLINK(RShank).max = 1;
[uLINK(RShank).vertex, uLINK(RShank).face] = MakeBox(uLINK(RShank).c,[0.08,0.07,0.11]);
[uLINK(RShank).skeleton.vertex, uLINK(RShank).skeleton.face] = MakeBox(uLINK(RShank).c,[0.005,0.005,0.11]);

uLINK(RAnkle).name = 'RAnkle';
uLINK(RAnkle).mother = RShank;
uLINK(RAnkle).sister = 0;
uLINK(RAnkle).child = RFoot;
uLINK(RAnkle).a = [1,0,0]';
uLINK(RAnkle).b = [0,0,-0.1]';
uLINK(RAnkle).c = [0,0,0]';
uLINK(RAnkle).q = 0;
uLINK(RAnkle).m = AnkleMass;
uLINK(RAnkle).min = -45;
uLINK(RAnkle).max = 75;
[uLINK(RAnkle).vertex, uLINK(RAnkle).face] = MakeSphere(uLINK(RAnkle).c,0.01);
[uLINK(RAnkle).skeleton.vertex, uLINK(RAnkle).skeleton.face] = MakeSphere(uLINK(RAnkle).c,0.01);

uLINK(RFoot).name = 'RFoot';
uLINK(RFoot).mother = RAnkle;
uLINK(RFoot).sister = 0;
uLINK(RFoot).child = 0;
uLINK(RFoot).a = [0,1,0]';
uLINK(RFoot).b = [0,0,0]';
uLINK(RFoot).c = [0,0.03,-0.04]';
uLINK(RFoot).q = 0;
uLINK(RFoot).m = FootMass;
uLINK(RFoot).min = -25;
uLINK(RFoot).max = 45;
[uLINK(RFoot).vertex, uLINK(RFoot).face] = MakeBox(uLINK(RFoot).c,[0.08,0.16,0.02]);
[uLINK(RFoot).skeleton.vertex, uLINK(RFoot).skeleton.face] = MakeBox(uLINK(RFoot).c,[0.08,0.16,0.02]);

%% Left Leg
uLINK(LHip1).name = 'LHip1';
uLINK(LHip1).mother = Torso;
uLINK(LHip1).sister = 0;
uLINK(LHip1).child = LHip2;
uLINK(LHip1).a = [-0.7071,0,-0.7071]';
uLINK(LHip1).b = [-0.055,-0.01,-0.115]';
uLINK(LHip1).c = [0,0,0]';
uLINK(LHip1).q = 0;
uLINK(LHip1).m = Hip1Mass;
uLINK(LHip1).min = -90;
uLINK(LHip1).max = 1;
[uLINK(LHip1).vertex, uLINK(LHip1).face] = MakeSphere(uLINK(LHip1).c,0.01);
[uLINK(LHip1).skeleton.vertex, uLINK(LHip1).skeleton.face] = MakeSphere(uLINK(LHip1).c,0.01);


uLINK(LHip2).name = 'LHip2';
uLINK(LHip2).mother = LHip1;
uLINK(LHip2).sister = 0;
uLINK(LHip2).child = LThigh;
uLINK(LHip2).a = [0,1,0]';
uLINK(LHip2).b = [0,0,0]';
uLINK(LHip2).c = [0,0,0]';
uLINK(LHip2).q = 0;
uLINK(LHip2).m = Hip2Mass;
uLINK(LHip2).min = -25;
uLINK(LHip2).max = 45;
[uLINK(LHip2).vertex, uLINK(LHip2).face] = MakeSphere(uLINK(LHip2).c,0.01);
[uLINK(LHip2).skeleton.vertex, uLINK(LHip2).skeleton.face] = MakeSphere(uLINK(LHip2).c,0.01);


uLINK(LThigh).name = 'LThigh';
uLINK(LThigh).mother = LHip2;
uLINK(LThigh).sister = 0;
uLINK(LThigh).child = LShank;
uLINK(LThigh).a = [1,0,0]';
uLINK(LThigh).b = [0,0,0]';
uLINK(LThigh).c = [0,0.01,-0.04]';
uLINK(LThigh).q = 0;
uLINK(LThigh).m = ThighMass;
uLINK(LThigh).min = -25;
uLINK(LThigh).max = 100;
[uLINK(LThigh).vertex, uLINK(LThigh).face] = MakeBox(uLINK(LThigh).c,[0.07,0.07,0.14]);
[uLINK(LThigh).skeleton.vertex, uLINK(LThigh).skeleton.face] = MakeBox(uLINK(LThigh).c,[0.005,0.005,0.14]);

uLINK(LShank).name = 'LShank';
uLINK(LShank).mother = LThigh;
uLINK(LShank).sister = 0;
uLINK(LShank).child = LAnkle;
uLINK(LShank).a = [1,0,0]';
uLINK(LShank).b = [0,0.005,-0.120]';
uLINK(LShank).c = [0,0.01,-0.045]';
uLINK(LShank).q = 0;
uLINK(LShank).m = ShankMass;
uLINK(LShank).min = -130;
uLINK(LShank).max = 1;
[uLINK(LShank).vertex, uLINK(LShank).face] = MakeBox(uLINK(LShank).c,[0.08,0.07,0.11]);
[uLINK(LShank).skeleton.vertex, uLINK(LShank).skeleton.face] = MakeBox(uLINK(LShank).c,[0.005,0.005,0.11]);

uLINK(LAnkle).name = 'LAnkle';
uLINK(LAnkle).mother = LShank;
uLINK(LAnkle).sister = 0;
uLINK(LAnkle).child = LFoot;
uLINK(LAnkle).a = [1,0,0]';
uLINK(LAnkle).b = [0,0,-0.1]';
uLINK(LAnkle).c = [0,0,0]';
uLINK(LAnkle).q = 0;
uLINK(LAnkle).m = AnkleMass;
uLINK(LAnkle).min = -45;
uLINK(LAnkle).max = 75;
[uLINK(LAnkle).vertex, uLINK(LAnkle).face] = MakeSphere(uLINK(LAnkle).c,0.01);
[uLINK(LAnkle).skeleton.vertex, uLINK(LAnkle).skeleton.face] = MakeSphere(uLINK(LAnkle).c,0.01);

uLINK(LFoot).name = 'LFoot';
uLINK(LFoot).mother = LAnkle;
uLINK(LFoot).sister = 0;
uLINK(LFoot).child = 0;
uLINK(LFoot).a = [0,1,0]';
uLINK(LFoot).b = [0,0,0]';
uLINK(LFoot).c = [0,0.03,-0.04]';
uLINK(LFoot).q = 0;
uLINK(LFoot).m = FootMass;
uLINK(LFoot).min = -45;
uLINK(LFoot).max = 25;
[uLINK(LFoot).vertex, uLINK(LFoot).face] = MakeBox(uLINK(LFoot).c,[0.08,0.16,0.02]);
[uLINK(LFoot).skeleton.vertex, uLINK(LFoot).skeleton.face] = MakeBox(uLINK(LFoot).c,[0.08,0.16,0.02]);

%%
PrintLinkName(Torso);
ForwardKinematics(Torso);