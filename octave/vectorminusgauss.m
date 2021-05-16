function vectorminusgauss=vectorminusgauss(peak,vector,mu,sigma,A,B,cut)
%disp('vectorminusgauss=vectorminusgauss(vector,mu,sigma)')
gauss=@(x)A/(2*pi*sigma)^(1/2)*exp(-(x-mu).^2/(2*sigma)^2)+B;
%if
if (mu>length(vector))
disp('mu>length(vector)')
vectorminusgauss=vector+1;
endif
if (sigma>40)&&(peak)
disp('sigma>length(vector)')
vectorminusgauss=2*abs(vector);
else
if (mu-ceil(sigma/2)<0)&&(peak)
disp('mu-ceil(sigma/2)<0')
vectorminusgauss=2*abs(vector);
endif
if (length(vector)-mu-floor(sigma/2)<0)&&(peak)
disp('length(vector)-mu-floor(sigma/2)<0')
vectorminusgauss=2*abs(vector);
endif
endif
%disp('vector size')
%size(vector)

if (mu<=length(vector))&&(mu-ceil(sigma/2)>=0)&&(length(vector)-mu-floor(sigma/2)>=0)&&(sigma<=length(vector))||(sigma<40&&peak)
disp('condition on param hitted')
vectorminusgauss=vector-gauss([1:length(vector)]')
if (peak)
disp('peak inside hitted')
gci=find(vectorminusgauss>cut)
vectorminusgauss(gci)=cut
cut
endif
ni=find(vectorminusgauss<0)
vectorminusgauss(ni)=vector(ni)+1;
gmaxi=find(vectorminusgauss>max(vector))
vectorminusgauss(gmaxi)=max(vector)+1;
%plot(vectorminusgauss)
%pause
else
disp('condition on param missed')
disp('mu')
mu
disp('length(vector)')
length(vector)
disp('mu-ceil(sigma/2)')
mu-ceil(sigma/2)
disp('length(vector)-mu-floor(sigma/2)')
length(vector)-mu-floor(sigma/2)
endif

endfunction
