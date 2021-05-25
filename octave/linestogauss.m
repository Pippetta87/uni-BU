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
plot(gauss([1:length(linescut)]));
hold on;
plot(obscut);
endif
if (strcmpi(zerofit,"sinc"))
chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#X=fminsearch(chiquadro,[round(length(obscut)/2);500;1000;200])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000;200],chiquadro,[],@(a)[a(1);a(2);a(3);a(4)])
mysinc=@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4);
plot(mysinc([1:length(linescut)]));
hold on;
plot(obscut);
obscuttwo=obscut-mylor([1:length(linescut)])'
size(obscuttwo)
max(obscuttwo)
find(max(obscuttwo))
endif
if (strcmpi(zerofit,"lor"))
chiquadro=@(a) sum((vectorminusf(@(x)a(2)/pi./((x-a(1)).^2+a(2)^2)+a(3),obscut,round(a(1)),a(2),a(3))).^2);
#chiquadro=@(a) sum((vectorminusf(@(x)a(3)	*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#X=fminsearch(chiquadro,[round(length(obscut)/2);500;1000;200])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000],chiquadro,[],@(a)[a(1);a(2);a(3)])
mylor=@(x)a(2)/pi./((x-a(1)).^2+a(2)^2)+a(3);
#fbgd=figure
%plot(mylor([1:length(linescut)]))
%hold on
%plot(obscut)
obscuttwo=obscut-mylor([1:length(linescut)])'
plot(log(obscuttwo),'+')
endif
%pause
%closereq()
peak=1
onefit="gauss2points"

%%%
difference=diff(obscuttwo);%derivata discreta del taglio a meta'
auxsmooth=find(abs(difference)<200);
difference(auxsmooth)=0
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

global M=find(max(obscuttwo(auxpeak))==obscuttwo)
Mother=auxpeak(find(abs(auxpeak-M)<=10))
global xd;
global yd;
global xdleft;
global ydleft;
%xd(1)=plateau(1);%old method
xdleft(1)=M(1);
xdleft(2)=xdleft(1)-1;
xdleft(3)=xdleft(2)-1;
xd(1)=Mother(2);
xd(2)=xd(1)-1;
xd(3)=xd(2)-1;
#xd(2)=-find(obscuttwo(M-alpha:M+beta)<=0.95*max(obscuttwo))(1)+M-alpha
#xd(3)=-find(obscuttwo(M-alpha:M+beta)<=0.85*max(obscuttwo))(1)+M-alpha
yd(1)=obscuttwo(xd(1))
yd(2)=obscuttwo(xd(2))
yd(3)=obscuttwo(xd(3))
ydleft(1)=obscuttwo(xdleft(1))
ydleft(2)=obscuttwo(xdleft(2))
ydleft(3)=obscuttwo(xdleft(3))
auxleft=xd(1)
function twopoints=gauss2p(param)
global xd
global yd
global M
global Mother
twopoints(1)=log(A(2)/(sqrt(2*pi)*sigma(1)))-log(yd(1)-offset(2))-(Mother(2)+offcenter(2))^2/(2*A(2)^2)+xd(1)*(offcenter(2)+Mother(2))/sigma(2)^2-xd(1)^2/(2*sigma(1)^2)+log(A(1)/(sqrt(2*pi)*sigma(1)))-log(ydleft(1)-offset(1))-(Mother(1)+offcenter(1))^2/(2*sigma(1)^2)+xdleft(1)*(offset(1)+Mother(1))/sigma(1)^2-xdleft(1)^2/(2*sigma(1)^2);
twopoints(2)=log(A(2)/(sqrt(2*pi)*sigma(1)))-log(yd(2)-offset(2))-(Mother(2)+offcenter(2))^2/(2*A(2)^2)+xd(2)*(offcenter(2)+Mother(2))/sigma(2)^2-xd(2)^2/(2*sigma(1)^2)+log(A(1)/(sqrt(2*pi)*sigma(1)))-log(ydleft(2)-offset(1))-(Mother(1)+offcenter(1))^2/(2*sigma(1)^2)+xdleft(2)*(offset(1)+Mother(1))/sigma(1)^2-xdleft(2)^2/(2*sigma(1)^2);
twopoints(3)=log(A(2)/(sqrt(2*pi)*sigma(1)))-log(yd(3)-offset(2))-(Mother(2)+offcenter(2))^2/(2*A(2)^2)+xd(3)*(offcenter(2)+Mother(2))/sigma(2)^2-xd(3)^2/(2*sigma(1)^2)+log(A(1)/(sqrt(2*pi)*sigma(1)))-log(ydleft(3)-offset(1))-(Mother(1)+offcenter(1))^2/(2*sigma(1)^2)+xdleft(3)*(offset(1)+Mother(1))/sigma(1)^2-xdleft(3)^2/(2*sigma(1)^2);
twopoints(4)=1e6*max(abs(offcenter(1))-5,0)^4;
twopoints(5)=1e6*max(abs(offcenter(2))-5,0)^4;
twopoints(6)=1e6*max(abs(A(1)/(2*pi*sigma(1))^(1/2)*exp(-(xdleft(1)-(sigma(1)+offcenter(1))).^2/(2*sigma(1))^2))-200000,0)^4;
twopoints(7)=1e6*max(abs(A(2)/(2*pi*sigma(2))^(1/2)*exp(-(xd(1)-(sigma(2)+offcenter(2))).^2/(2*sigma(2))^2))-200000,0)^4;
twopoints(8)=1e6*max(abs(offset(1))-5000,0)^4;
twopoints(9)=1e6*max(abs(offset(2))-5000,0)^4;
endfunction
if (strcmpi(onefit,"gauss2points"))
options.TolFun=10^-40;options.TolX=10^-40;
%param=@(A,sigma,offcenter,offset)[A; sigma; offcenter; offset];
[param,info]=fsolve("gauss2p", [2*obscuttwo(Mother)'; [1 1];[0 0];[100 100]],options)
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
plot(gauss([1:length(linescut)]));
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

