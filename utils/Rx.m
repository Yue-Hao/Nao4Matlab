% by Hao Yue % Nov,21,2012
function T = Rx(a)

a = deg2rad(a);

T = [1 0 0 0;
     0 cos(a) -sin(a) 0;
     0 sin(a) cos(a) 0;
     0 0 0 1
     ];

end