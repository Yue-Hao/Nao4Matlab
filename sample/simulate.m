% by Hao Yue % Nov,21,2012
Nao();

global uLINK;
global LFoot;

Dtime = 0.02;
T = 10;
t = 0:Dtime:T;
figure
range = [-1,1,-1,1,0,2];
frame_skip = 10;

px = -0.8 + 1.6 * t/T;
py = cos(t)+1;
pz = sin(t)+1;

for n = 1:length(t)

    p = [px,py,pz]
    uLINK(LFoot).R = eye(3);
    uLINK(LFoot).p = [px(n),py(n),pz(n)]';
    if mod(n,frame_skip) == 0
        newplot
        hold on
        h = ShowObject(LFoot);
        plot3(px(1:n),py(1:n),pz(1:n));
        %plot(TransMat(uLINK(LFoot).R,uLINK(LFoot).p));
        axis(range);
        view([45 20]);
        xlabel('x')
        ylabel('y')
        zlabel('z')
        %hold off
        drawnow
        pause(Dtime);
    end
    
end