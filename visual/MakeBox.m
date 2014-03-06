% by Hao Yue % Nov,21,2012
function [vert,face] = MakeBox(pos, wdh)

vert = 0.5 * [
    -wdh(1) -wdh(2) -wdh(3);
    -wdh(1)  wdh(2) -wdh(3);
     wdh(1)  wdh(2) -wdh(3);
     wdh(1) -wdh(2) -wdh(3);
    -wdh(1) -wdh(2)  wdh(3);
    -wdh(1)  wdh(2)  wdh(3);
     wdh(1)  wdh(2)  wdh(3);
     wdh(1) -wdh(2)  wdh(3);
     ]';
vert = vert + repmat(pos,1,size(vert,2));
 
face = [
    1 2 3 4;
    2 6 7 3;
    4 3 7 8;
    1 5 8 4;
    1 2 6 5;
    5 6 7 8;
    ];
end
