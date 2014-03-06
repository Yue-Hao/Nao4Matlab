

t = 0:0.01:0.3
yy = Spline(t_foot_pos,x_a,t);
yy2 = spline(t_foot_pos,x_a,t);
plot(t,yy)
hold on
plot(t,yy2,'k')

plot(t_foot_pos,x_a,'r.')


%%
w = [1 1 1];
a = [ 0 -w(3) w(2);
     w(3) 0  -w(1);
     -w(2) w(1) 0;]
pinv(a)

%%
mean(poswithangle)
mean(posnoangle)
plot(poswithangle(:,1),poswithangle(:,2),'r.')
hold on
plot(posnoangle(:,1),posnoangle(:,2),'b.')
axis equal