% by Hao Yue % Nov,21,2012
function err = CalcVWerr(Cref,Cnow)

perr = Cref.p - Cnow.p;
Rerr = Cnow.R^-1 * Cref.R;
werr = Cnow.R * rot2omega(Rerr);
err = [perr; werr];

end