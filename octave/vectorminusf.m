function vectorminusf=vectorminusf(fun,vector)
%disp('vectorminusf=vectorminusf(@fun,vector)')
vectorminusf=vector-abs(fun([1:length(vector)]'));
ni=find(vectorminusf<0);
vectorminusf(ni)=abs(vectorminusf(ni))+var(vector);

#{
if (mu>length(vector))
disp('mu>length(vector)')
mu=length(vector);
vectorminusgauss=vector;
endif
if (sigma<0)
disp('sigma<0')
sigma=0;
vectorminusgauss=vector;
endif
if (sigma>length(vector))
disp('sigma>length(vector)')
sigma=length(vector);
vectorminusgauss=vector-gauss([1:length(vector)]);
endif
if (mu<0)
disp('mu<0')
mu=0;
vectorminusgauss=vector;
endif
if (mu-ceil(sigma/2)<0)
disp('mu-ceil(sigma/2)<0')
mu=length(vector);
sigma=floor(length(vector)/2);
vectorminusgauss=vector-gauss([1:length(vector)]);
endif
if (length(vector)-mu-floor(sigma/2)<0)
disp('length(vector)-mu-floor(sigma/2)<0')
mu=length(vector)-floor(sigma/2);
vectorminusgauss=vector-gauss([1:length(vector)]);
endif

disp('vector size')
size(vector)

if (mu<=length(vector))&&(sigma>=0)&&(mu>=0)&&(mu-ceil(sigma/2)>=0)&&(length(vector)-mu-floor(sigma/2)>=0)
vectorminusgauss=vector-gauss([1:length(vector)]');
ni=find(vectorminusgauss<0);
vectorminusgauss(ni)=2^16;
else
disp('condition on param missed')
endif
endfunction
#}
