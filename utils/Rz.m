% by Hao Yue % Nov,21,2012
function T = Rz(a)

a = deg2rad(a);

T = [cos(a) -sin(a) 0 0;
     sin(a) cos(a) 0 0;
     0 0 1 0;
     0 0 0 1
     ];

end