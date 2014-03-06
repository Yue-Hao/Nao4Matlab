% by Hao Yue % Nov,21,2012
%% skew symmetric matrix [w_hat]' = -[w_hat]
function w_hat = Hat(w)
w_hat = [ 
     0   -w(3)  w(2);
     w(3)   0  -w(1);
     -w(2) w(1)    0;
     ];