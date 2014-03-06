function ShowWalkingOnGround(X,dX,R,P,z,T,Tsup,sz)

sz = sz*0.5;
foot = [sz(1) -sz(1) -sz(1) sz(1) sz(1) sz(1) -sz(1);
        sz(2) sz(2)  -sz(2) -sz(2) sz(2) sz(2)*0.9 sz(2)*0.9];
for i = 1:length(foot)
    foot(:,i) = P + R * foot(:,i);
end
plot(P(1),P(2),'k+');
plot(foot(1,:),foot(2,:),'k-');
text(P(1)+0.05, P(2)+0.05, num2str(T, '%.2f'));

g = 9.81;
DTime = Tsup/10;
time = 0:DTime:Tsup;
Tc = (z/g)^(0.5);
Xt = zeros(2,length(time));
dXt = zeros(2,length(time));
ddXt= zeros(2,length(time));
for n = 1:length(time)
    t = time(n)/Tc;
    C = cosh(t);
    S = sinh(t);
    Xt(:,n) = ( X - P ) * C  + Tc * dX * S + P;
    dXt(:,n) = (X - P ) / Tc * S + dX * C;
    ddXt(:,n) = g/z*(Xt(:,n)-P);
end
plot(Xt(1,:), Xt(2,:),'m-','LineWidth',3);