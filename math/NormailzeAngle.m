% by Hao Yue % Nov,21,2012
function r = NormailzeAngle(ang)

r = ang;

while (r > 180)
    r = r - 360;
end

while (r <= -180)
    r = r + 360;
end

end