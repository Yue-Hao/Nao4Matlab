% by Hao Yue % Nov,21,2012
function [vert, face] = MakeCylinder(pos,radius,len)

a = 10;
theta = (0:a-1)/a * 2 * pi;

x = radius*cos(theta);
y = radius*sin(theta);
z1 = len/2 * ones(1,a);
z2 = -z1;

vert = [ x x 0 0;
         y y 0 0;
         z1 z2 len/2 -len/2];
     
vert = vert + repmat(pos,1,size(vert,2));

face_side = [1:a; a+1:2*a; a+2:2*a a+1; 2:a 1];
face_up = [1:a; 2:a 1];
face_up(3:4,:) = 2*a+1;
face_down = [a+2:2*a a+1; a+1:2*a];
face_down(3:4,:) = 2*a +2;

face = [face_side face_up face_down]';

end