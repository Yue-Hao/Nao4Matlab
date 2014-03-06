% by Hao Yue % Nov,21,2012
function m = TotalMass(j)

global uLINK
if j == 0
    m = 0;
else
    m = uLINK(j).m + TotalMass(uLINK(j).sister) + TotalMass(uLINK(j).child);
end

end