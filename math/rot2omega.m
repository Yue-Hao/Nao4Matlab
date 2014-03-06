% by Hao Yue % Nov,21,2012
function w = rot2omega(R)

if R == eye(3)
    w = [0 0 0]';
else
    theta = acos( (R(1,1)+R(2,2)+R(3,3)-1)/2 );
    if theta < eps
        w = 0.5 * [R(3,2)-R(2,3) R(1,3)-R(3,1) R(2,1)-R(1,2)]';
    else
        w = theta/2/sin(theta) * [R(3,2)-R(2,3) R(1,3)-R(3,1) R(2,1)-R(1,2)]';
    end
end