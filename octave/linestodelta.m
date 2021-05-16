disp('########################')
disp('LINES TO DELTA')
disp('########################')
obscut=neon(:,floor(length(neon)/2));
ndelta=length(neonlines);
#vectorplusdelta(vector,dpos,dheight,dweight)
chiquadro=@(a) sum((vectorminusdelta(obscut',round(a(1)),a(2),round(a(3)))).^2);
#chiquadro=@(a) sum((vectorminusdelta([2 2 2 2 2 10 16 10 5 2 2 2 2],round(a(1)),a(2),round(a(3)))).^2);
#disp('vectorminusdelta(vector,dpos,dheight,dweight)')
X=fminsearch(chiquadro,[round(length(obscut)/2);100;20])
