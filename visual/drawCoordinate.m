% by Hao Yue % Nov,21,2012
function h = drawCoordinate(T)

p = T(1:3,4);
T(1:3,1:3) = T(1:3,1:3) + [p p p];
h = plot3([p(1),T(1,1)],[p(2),T(2,1)],[p(3),T(3,1)],'b',...
    [p(1),T(1,2)],[p(2),T(2,2)],[p(3),T(3,2)],'r',...
    [p(1),T(1,3)],[p(2),T(2,3)],[p(3),T(3,3)],'g');
end