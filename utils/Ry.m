% by Hao Yue % Nov,21,2012
function T = Ry(a)

a = deg2rad(a);

T = [cos(a) 0 sin(a) 0;
     0 1 0 0;
     -sin(a) 0 cos(a) 0;
     0 0 0 1
     ];

end