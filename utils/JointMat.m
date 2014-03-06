% by Hao Yue % Nov,21,2012
function T = JointMat(theta,alpha,d,a)

T = Rx(alpha)*Trans([a,0,0])*Rz(theta)*Trans([0,0,d]);

end