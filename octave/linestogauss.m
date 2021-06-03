disp('########################')
disp('LINES TO GAUSS')
disp('########################')
C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]};% Cell array of colros.ù
global isplateau;
global xpeak;
global Mother;
global M=[];
global xd;
global yd;
global lenplateau;
wingside={};
%axisa: mysinc, obscut, auxpeak(*)
%axisc: obscuttwo,obscuttwo-gauss1,-gauss2,M
%axisb:xd,yd,gauss1,gauss2, obscuttwo
if !(exist("neon"))
moonneon;
endif
obscut=neon(:,floor(length(neon)/2))+sinc(([1:length(neon)]'-1000)/500).^2;
ndelta=10;
zerofit="sinc"
peak=0
realpeaks=[];%peaks after gaussian fit

function twopoints=gauss2p(param)%
global xd;
global yd;
global xpeak;
global isplateau;
global M;
global lenplateau;
twopoints(1)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(1))-(xpeak+param(3))^2/(2*param(1)^2)+xd(1)*(param(3)+xpeak)/param(1)^2-xd(1)^2/(2*param(1)^2);
if yd(1)>yd(2)
twopoints(2)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(2))-(xpeak+param(3))^2/(2*param(1)^2)+xd(2)*(param(3)+xpeak)/param(1)^2-xd(2)^2/(2*param(1)^2);
endif
if (yd(1)>yd(2))&&(yd(2)>yd(3))
twopoints(3)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(3))-(xpeak+param(3))^2/(2*param(1)^2)+xd(3)*(param(3)+xpeak)/param(1)^2-xd(3)^2/(2*param(1)^2);
endif
if (yd(1)>yd(2))&&(yd(2)>yd(3))&&(yd(3)>yd(4))
twopoints(4)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(4))-(xpeak+param(3))^2/(2*param(1)^2)+xd(4)*(param(3)+xpeak)/param(1)^2-xd(4)^2/(2*param(1)^2);
endif
if (yd(1)>yd(2))&&(yd(2)>yd(3))&&(yd(3)>yd(4))&&(yd(4)>yd(5))
twopoints(5)=log(param(2)/(sqrt(2*pi)*param(1)))-log(yd(5))-(xpeak+param(3))^2/(2*param(1)^2)+xd(5)*(param(3)+xpeak)/param(1)^2-xd(5)^2/(2*param(1)^2);
endif
if !(isplateau)%offcenter(1)
disp('no offcenter')
twopoints(4)=1e6*max(abs(param(3)),0)^4;
else
twopoints(4)=1e6*max(abs(param(3))-2,0)^4;
endif
twopoints(5)=1e6*max(abs(param(2)/(2*pi*param(1)^2)^(1/2))-250000,0)^4;
%max(-abs(param(2)/(2*pi*param(1)^2)^(1/2))+yd(1),0)
%twopoints(6)=1e6*max(-abs(param(2)/(2*pi*param(1)^2)^(1/2))+yd(1),0)^4;
%twopoints(7)=1e6*max(abs(param(4))-500,0)^4;
if length(M)>1
twopoints(6)=1e6*max(abs(param(1))-(M(1)-M(2)-2)/2,0)^4;
else
twopoints(6)=1e6*max(abs(param(1))-(lenplateau)/2,0)^4;
%if (isplateau)%peak above plateau
%twopoints(7)=1e6*max(-abs(param(2)/(2*pi*param(1)^2)^(1/2))+yd(1),0)^4;
%twopoints(8)=1e20*(abs(imag(param(1)))>0);
%twopoints(9)=1e20*(abs(imag(param(2)))>0);
%twopoints(10)=1e20*(abs(imag(param(3)))>0);
%endif
endif
endfunction

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
pfitinterf=plot(gauss([1:length(obscut)]));
pdata=plot(obscut);
endif
if (strcmpi(zerofit,"sinc"))
chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#chiquadro=@(a) sum((vectorminusf(@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4),obscut,round(a(1)),a(2),a(3),a(4))).^2);
#X=fminsearch(chiquadro,[round(length(obscut)/2);500;1000;200])
[a, obj, info, iter, nf, lambda]=sqp([round(length(obscut)/2);500;1000;200],chiquadro,[],@(a)[a(1);a(2);a(3);a(4)])
mysinc=@(x)a(3)*sinc((x-a(1))/a(2)).^2+a(4);
obscuttwo=obscut-mysinc([1:length(obscut)])';
size(obscuttwo);
max(obscuttwo);
find(max(obscuttwo));
figure
pdataredux=plot(obscuttwo)
title("axisb");
axisb=gca;
if !(ishold(axisb))
hold(axisb);
endif
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

figure
pfitinterf=plot(mysinc([1:length(obscut)]));
title("axisa");
axisa=gca
if !(ishold(axisa))
hold(axisa);
endif
pdatasub=plot(axisa,obscut);
figure
pfitinterf=plot(obscuttwo);
title("axisc");
axisc=gca;
if !(ishold(axisc))
hold(axisc);
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
hold on;
pauxpeak=plot(axisa,auxpeak,10000*ones(length(auxpeak),1),'*')
%plot(difference)
%hold on
%plot(diffth,ones(length(diffth),1),'.')
%plot(segno)

if (strcmpi(onefit,"gauss2points"))
for i=1:length(auxpeak)
try
%clear("pM","psub2","psub1","pfitpoints1","pfitpeak1")
catch err
  disp(err)
end_try_catch
isplateau='false'
xpeak=[]
Mother=[]
M=[]
yd=[]
xd=[]
i
M
pause
clear gauss1param;
clear gauss2param;
M(1)=auxpeak(find(max(obscuttwo(auxpeak))==obscuttwo(auxpeak)))
Mother=auxpeak(find(abs(auxpeak-M(1))<=10))
min(obscuttwo(Mother))
pause

if (length(Mother)>1)%calcolo parametri picco di M(2) se length Mother>1
M(2)=Mother(find(min(obscuttwo(Mother))==obscuttwo(Mother)))
(M(1)-M(2)-1)/2
pause
plateau=find(obscuttwo(M(2))-1.2<=obscuttwo);%old max1
if length(plateau)>1
isplateau=true
else
isplateau=false
endif
plateau(find(abs(M(2)-plateau)<=5))
wingside{2}=plateau(find(abs(M(2)-plateau)<=5))
M2left(2)=wingside{2}(1)
M2right(2)=wingside{2}(end)
if (false)
xd(1)=M2right(2)
xpeak=xd(1);
xd(2)=xd(1)+1
xd(3)=xd(2)+1
xd(4)=xd(3)+1
xd(5)=xd(4)+1
else
xd(1)=M2left(2)
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
gauss2=@(x)gauss2param(2)/(2*pi*gauss2param(1)^2)^(1/2)*exp(-(x-xpeak-gauss2param(3)).^2/(2*gauss2param(1)^2))+gauss2param(4);
psub2=plot(axisc,([M(2)-20:M(2)+19]),obscuttwo([M(2)-20:M(2)+19])'-gauss2([M(2)-20:M(2)+19]),'.');
obscuttwo-=gauss2([1:length(obscut)])';
pfitpeak2=plot(axisb,gauss2([1:length(obscut)]));
pfitpoints2=plot(axisb,xd,yd,'+');
realpeaks(end+2)=M(2)+gauss2param(3)
endif

plateau=find(obscuttwo(M(1))-1.2<=obscuttwo)%find parameters of peak 1 after that for peak 2(if length(Mother)>1)
if length(plateau)>1
isplateau=true
else
isplateau=false
endif
wingside{1}=plateau(find(abs(M(1)-plateau)<=5));
Mleft(1)=wingside{1}(1)
Mright(1)=wingside{1}(end)
lenplateau=Mright(1)-Mleft(1)
if (true)
xd(1)=Mright(1)
xpeak=xd(1);
xd(2)=xd(1)+1
xd(3)=xd(2)+1
xd(4)=xd(3)+1
xd(5)=xd(4)+1
else
xd(1)=Mleft(1)
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

options.TolFun=10^-40;options.TolX=10^-40;
%param=@(A,sigma,offcenter,offset)[A; sigma; offcenter; offset];
%[param,info]=myfsolve("gauss2p", [2*obscuttwo(Mother) [1 1]' [0 0]' [100 100]'],options)%matrix of param
%[param,info]=fsolve("gauss2p", [2*obscuttwo(Mother(1)) 1 0 0 2*obscuttwo(Mother(2)) 1 0 0]',options)%vector of param
M

pause
[gauss1param,info]=fsolve("gauss2p", [2*obscuttwo(M(1)) 1 1 0]',options);%vector of param
gauss1=@(x)gauss1param(2)/(2*pi*gauss1param(1)^2)^(1/2)*exp(-(x-xpeak-gauss1param(3)).^2/(2*gauss1param(1)^2))+gauss1param(4)
pfitpeak1=plot(axisb,gauss1([1:length(obscut)]))
pfitpoints1=plot(axisb,xd,yd,'+')
psub1=plot(axisc,obscuttwo'-gauss1([1:length(obscut)]),'.')
pM=plot(axisc,M,10000*ones(length(M),1),'o')

realpeaks(end+1)=M(1)+gauss1param(3)
gauss1param
if exist("gauss2param")
gauss2param
endif

obscuttwo-=gauss1([1:length(obscut)])';

i
length(realpeaks)
M(1)
Mother
imag(gauss1param)
if exist("gauss2param")
imag(gauss2param)
endif
pause

endfor
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

