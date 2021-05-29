disp('########################')
disp('LINES TO GAUSS')
disp('########################')
obscut=neon(:,floor(length(neon)/2))+sinc(([1:length(neon)]'-1000)/500).^2;
ndelta=10;
zerofit="sinc"
peak=0
%[x, obj, info, iter, nf, lambda] = sqp (x0, phi)
%[…] = sqp (x0, phi, g)
%[…] = sqp (x0, phi, g, h)
%[…] = sqp (x0, phi, g, h, lb, ub)
%[…] = sqp (x0, phi, g, h, lb, ub, maxiter)
%[…] = sqp (x0, phi, g, h, lb, ub, maxiter, tol)
%    Minimize an objective function using sequential quadratic programming (SQP).
%    Solve the nonlinear program
%    min phi (x)
%     x
%    subject to
%    g(x)  = 0
%    h(x) >= 0
%    lb <= x <= ub

if (strcmpi(zerofit,"gauss"))
chiquadro=@(a) sum((vectorminusgauss(peak,obscut,round(a(1)),a(2),a(3),a(4),a(5))).^2);
%X=fminsearch(chiquadro,[round(length(obscut)/2);1;5000;100])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000;200;0.1],chiquadro,[],@(a)[a(1);a(2);a(3);a(4);a(5)])
gauss=@(x)a(3)/(2*pi*a(2))^(1/2)*exp(-(x-a(1)).^2/(2*a(2))^2)+a(4);
plot(gauss([1:length(obscut)]));
hold on;
plot(obscut);
endif
if (strcmpi(zerofit,"sinc"))
chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#X=fminsearch(chiquadro,[round(length(obscut)/2);500;1000;200])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000;200],chiquadro,[],@(a)[a(1);a(2);a(3);a(4)])
mysinc=@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4);
plot(mysinc([1:length(obscut)]));
hold on;
plot(obscut);
obscuttwo=obscut-mysinc([1:length(obscut)])';
size(obscuttwo);
max(obscuttwo);
find(max(obscuttwo));
endif
if (strcmpi(zerofit,"lor"))
chiquadro=@(a) sum((vectorminusf(@(x)a(2)/pi./((x-a(1)).^2+a(2)^2)+a(3),obscut,round(a(1)),a(2),a(3))).^2);
#chiquadro=@(a) sum((vectorminusf(@(x)a(3)	*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#X=fminsearch(chiquadro,[round(length(obscut)/2);500;1000;200])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000],chiquadro,[],@(a)[a(1);a(2);a(3)])
mylor=@(x)a(2)/pi./((x-a(1)).^2+a(2)^2)+a(3);
#fbgd=figure
%plot(mylor([1:length(obscut)]))
%hold on
%plot(obscut)
isremovedsinc=true;
if (isremovedsinc)
obscuttwo=obscut-mylor([1:length(obscut)])';
else
obscuttwo=obscut;
endif
plot(log(obscuttwo),'+')
endif
%pause
%closereq()
peak=1
onefit="gauss2points"

%%%
difference=diff(obscuttwo);%derivata discreta del taglio a meta'
auxsmooth=find(abs(difference)<200);
difference(auxsmooth)=0;
diffconseqsign=difference(1:end-1).*difference(2:end);%differenze con segno uguale: positivo
%find(difference>=0)
diffcp=find(diffconseqsign>0);%differenze con segno positivo consequenziali
diffcn=find(diffconseqsign<=0);%differenze con segno negativo consequenziali
segno=zeros(length(diffconseqsign)+1,1);%inizializzo segno
segno(diffcp+1)+=1000;%segno differenze uguale contiguo (+1)
segno(diffcn+1)-=1000;%segno diverso (-1)
segno(auxsmooth)=0;

auxs=find(segno<0);
auxcut=find(obscuttwo>mean(obscuttwo));
auxextr=auxs(ismember(auxs,auxcut));
auxw=2;
auxidxlr=ones(auxw*2+1,length(auxextr)).*auxextr'+[-auxw:auxw]';
auxflat=0;
lp=1;
l=0;
while (auxflat+1<=4)&&(lp>l)
auxmax=ones(auxw*2+1,length(auxextr)).*obscuttwo(auxextr)'+auxflat>=obscuttwo(auxidxlr);
auxpeak=auxextr(find(sum(auxmax)>=2*auxw));
l=length(auxpeak)
auxmax=ones(auxw*2+1,length(auxextr)).*obscuttwo(auxextr)'+auxflat+1>=obscuttwo(auxidxlr);
auxpeak=auxextr(find(sum(auxmax)>=2*auxw));
lp=length(auxpeak)
auxflat+=1
endwhile
plot(auxpeak,10000*ones(length(auxpeak),1),'*')
%plot(difference)
hold on
%plot(diffth,ones(length(diffth),1),'.')
%plot(segno)

%%%
%peaklmax=max(obscuttwo([auxleft-20:auxleft-5]))
%peakl=auxleft+find(max(obscuttwo([auxleft-20:auxleft-5]))==peaklmax)
%find(max(obscuttwo([auxleft-20:auxleft-5]))==peaklmax)
%minl=min(obscuttwo(auxleft-10:auxleft))
%minlx=find(obscuttwo(auxleft-10:auxleft)==minl)
%peakllmin=min(obscuttwo(auxleft-10:auxleft-10+peakl))
%plot(peakl,peaklmax,'+')

%fittin first group of peak
%max1=find(max(obscuttwo)-0.2<=obscuttwo);%old method
%plateau=max1(find(abs(find(obscuttwo==max(obscuttwo))-max1)<=10));%old method
%global M=median(plateau);
%alpha=find(diff(obscuttwo(M:-1:1))>=0)(1);%old method
%beta=find(diff(obscuttwo(M:end))>=0)(1);%old method

global isplateau;
global xpeak;
global Mother;
M(1)=auxpeak(find(max(obscuttwo(auxpeak))==obscuttwo(auxpeak)))
Mother=auxpeak(find(abs(auxpeak-M(1))<=10));
plateau=find(obscuttwo(M(1))-1.2<=obscuttwo);%old max1
wingside=plateau(find(abs(M(1)-plateau)<=5));
Mleft=wingside(1)
Mright=wingside(end)
global xd;
global yd;

if (true)
xd(1)=Mright
xpeak=xd(1);
xd(2)=xd(1)+1
xd(3)=xd(2)+1
xd(4)=xd(3)+1
xd(5)=xd(4)+1
else
xd(1)=Mleft
xpeak=xd(1);
xd(2)=xd(1)-1
xd(3)=xd(2)-1
xd(4)=xd(3)-1
xd(5)=xd(4)-1
endif

#xd(2)=-find(obscuttwo(M-alpha:M+beta)<=0.95*max(obscuttwo))(1)+M-alpha
#xd(3)=-find(obscuttwo(M-alpha:M+beta)<=0.85*max(obscuttwo))(1)+M-alpha
yd(1)=obscuttwo(xd(1))
yd(2)=obscuttwo(xd(2))
yd(3)=obscuttwo(xd(3))
yd(4)=obscuttwo(xd(4))
yd(5)=obscuttwo(xd(5))
%ydleft(1)=obscuttwo(xdleft(1))
%ydleft(2)=obscuttwo(xdleft(2))
%ydleft(3)=obscuttwo(xdleft(3))

function twopoints=gauss2p(param)
global xd;
global yd;
global xpeak;
global isplateau;
twopoints(1)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(1))-(xpeak+param(3))^2/(2*param(1)^2)+xd(1)*(param(3)+xpeak)/param(1)^2-xd(1)^2/(2*param(1)^2);
twopoints(2)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(2))-(xpeak+param(3))^2/(2*param(1)^2)+xd(2)*(param(3)+xpeak)/param(1)^2-xd(2)^2/(2*param(1)^2);
twopoints(3)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(3))-(xpeak+param(3))^2/(2*param(1)^2)+xd(3)*(param(3)+xpeak)/param(1)^2-xd(3)^2/(2*param(1)^2);
twopoints(4)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(4))-(xpeak+param(3))^2/(2*param(1)^2)+xd(4)*(param(3)+xpeak)/param(1)^2-xd(4)^2/(2*param(1)^2);
twopoints(5)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(5))-(xpeak+param(3))^2/(2*param(1)^2)+xd(5)*(param(3)+xpeak)/param(1)^2-xd(5)^2/(2*param(1)^2);
if (isplateau)%offcenter(1)
disp('no offcenter')
twopoints(4)=1e6*max(abs(param(3)),0)^4;
else
twopoints(4)=1e6*max(abs(param(3))-2,0)^4;
endif
twopoints(5)=1e6*max(abs(param(2)/(2*pi*param(1)^2)^(1/2))-200000,0)^4;
%max(-abs(param(2)/(2*pi*param(1)^2)^(1/2))+yd(1),0)
%twopoints(6)=1e6*max(-abs(param(2)/(2*pi*param(1)^2)^(1/2))+yd(1),0)^4;
%twopoints(7)=1e6*max(abs(param(4))-500,0)^4;
twopoints(6)=1e6*max(abs(param(1))-3,0)^4;
endfunction

if (strcmpi(onefit,"gauss2points"))
options.TolFun=10^-40;options.TolX=10^-40;
%param=@(A,sigma,offcenter,offset)[A; sigma; offcenter; offset];
%[param,info]=myfsolve("gauss2p", [2*obscuttwo(Mother) [1 1]' [0 0]' [100 100]'],options)%matrix of param
%[param,info]=fsolve("gauss2p", [2*obscuttwo(Mother(1)) 1 0 0 2*obscuttwo(Mother(2)) 1 0 0]',options)%vector of param
isplateau=false
[gauss1param,info]=fsolve("gauss2p", [2*obscuttwo(M(1)) 1 1 0]',options);%vector of param
gauss=@(x)gauss1param(2)/(2*pi*gauss1param(1)^2)^(1/2)*exp(-(x-xpeak-gauss1param(3)).^2/(2*gauss1param(1)^2))+gauss1param(4)
hold on
plot(gauss([1:length(obscut)]))
plot(xd,yd,'+')
if (length(Mother)>1)
isplateau=true
M(2)=Mother(find(min(obscuttwo(Mother))==obscuttwo(Mother)))
plateau=find(obscuttwo(M(2))-1.2<=obscuttwo);%old max1
wingside=plateau(find(abs(M(2)-plateau)<=5))
M2left=wingside(1)
M2right=wingside(end)
if (false)
xd(1)=M2right
xpeak=xd(1);
xd(2)=xd(1)+1
xd(3)=xd(2)+1
xd(4)=xd(3)+1
xd(5)=xd(4)+1
else
xd(1)=M2left
xpeak=xd(1);
xd(2)=xd(1)-1
xd(3)=xd(2)-1
xd(4)=xd(3)-1
xd(5)=xd(4)-1

endif
yd(1)=obscuttwo(xd(1))
yd(2)=obscuttwo(xd(2))
yd(3)=obscuttwo(xd(3))
yd(4)=obscuttwo(xd(4))
yd(5)=obscuttwo(xd(5))
[gauss2param,info]=fsolve("gauss2p", [2*obscuttwo(M(2)) 1 0 0]',options);%vector of param
gauss=@(x)gauss2param(2)/(2*pi*gauss2param(1)^2)^(1/2)*exp(-(x-xpeak-gauss2param(3)).^2/(2*gauss2param(1)^2))+gauss2param(4);
hold on;
plot(gauss([1:length(obscut)]));
plot(xd,yd,'+');
gauss1param
gauss2param
endif
endif

if (strcmpi(onefit,"gauss"))
a(4)=0;
a(1)=M;
aux1=[M-alpha-3:M+beta-3];
plot(obscuttwo(aux1))
pause
chiquadro=@(aa)sum(vectorminusgauss(1,obscuttwo([M-alpha-3:M+beta-3]),M,aa(1),aa(2),0,max(obscuttwo)).^2);
[aa, obj, info, iter, nf, lambda]=sqp([2;max(obscuttwo)],chiquadro,[],@(aa)[aa(1);aa(2)],[],[],500)
%[a, obj, info, iter, nf, lambda]=sqp([median(plateau);1;max(obscuttwo);0],chiquadro,[],@(a)[a(1)-length(obscuttwo);a(1)-ceil(a(2)/2);-length(obscuttwo)+a(1)+floor(a(2)/2);a(2);a(3)])
%[F, a, CVG, ITER, CORP, COVP, COVR, STDRESID, Z, R2]=leasqr([a(1);a(2);a(3);a(4)],chiquadro(median(plateau),1,max(obscuttwo),0),[median(plateau);1;max(obscuttwo);0], chiquadro)
gauss=@(x)aa(2)/(2*pi*aa(1))^(1/2)*exp(-(x-a(1)).^2/(2*aa(1))^2)+a(4);
plot(gauss([1:length(obscut)]));
hold on;
plot(obscuttwo);
endif
if (strcmpi(onefit,"voigt"))
chiquadro=@(a)sum((vectorminusvoigt(obscuttwo,a(1),a(2),a(3))).^2);
[a, obj, info, iter, nf, lambda]=sqp([0;1;1],chiquadro,[],@(a)[a(1);a(2);a(3)])
z=(obscuttwo+a(1)*(1i))/(a(2)*sqrt(2));
voigt=real(exp(-z^2)*erfc(-zi))+a(3);
plot(voigt);
hold on;
plot(obscuttwo);
endif

