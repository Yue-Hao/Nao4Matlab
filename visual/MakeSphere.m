% by Hao Yue % Nov,21,2012
function [vert, face] = MakeSphere(pos,radius)

[x y z] = sphere(10);
[f v c] = surf2patch(x,y,z);

vert = radius * v';
vert = vert + repmat(pos,1,size(vert,2));

face = f;

end