% by Hao Yue % Nov,21,2012
function J = CalcJacobian(idx)

global uLINK

jsize = length(idx);
target = uLINK(idx(end)).p;
J = zeros(6,jsize);
for n = 1:jsize
    j = idx(n);
    a = uLINK(j).R * uLINK(j).a;
    J(:,n) = [cross(a, target-uLINK(j).p); a];
end

end