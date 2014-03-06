% by Hao Yue % Nov,21,2012
function Precalculation(j)
global uLink

if j == 0
    return;
end

uLink(j).R = eye(3);

Precalculation(uLink(j).child);
Precalculation(uLink(j).sister);

end