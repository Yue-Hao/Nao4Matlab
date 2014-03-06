% by Hao Yue % Nov,21,2012
function e = Rodrigues(w, t)

t = deg2rad(t);

E = eye(3);
w_mod = norm(w,2);

if w_mod < eps
     e = E;
else

w = w ./ w_mod;
a = [ 0 -w(3) w(2);
     w(3) 0  -w(1);
     -w(2) w(1) 0;];

e = E + a .* sin(w_mod*t) + a^2 .* (1-cos(w_mod*t));

end