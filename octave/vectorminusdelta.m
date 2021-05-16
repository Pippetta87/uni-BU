function vectorminusdelta=vectorminusdelta(vector,dpos,dheight,dweight)
disp('vectorminusdelta(vector,dpos,dheight,dweight)')
if (dpos>length(vector))
disp('dpos>length(vector)')
dpos=length(vector);
vectorminusdelta=vector;
endif
if (dweight<0)
disp('dweight<0')
dweight=0;
vectorminusdelta=vector;
endif
if (dweight>length(vector))
disp('dweight>length(vector)')
dweight=length(vector);
vectorminusdelta=vector-dheight*ones(1,length(vector));
endif
if (dpos<0)
disp('dpos<0')
dpos=0;
vectorminusdelta=vector;
endif
if (dpos-ceil(dweight/2)<0)
disp('dpos-ceil(dweight/2)<0')
dpos=length(vector);
dweight=floor(length(vector)/2);
height=mean(vector);
vectorminusdelta=vector-dheight*ones(1,length(vector));
endif
if (length(vector)-dpos-floor(dweight/2)<0)
disp('length(vector)-dpos-floor(dweight/2)<0')
dpos=length(vector)-floor(dweight/2);
#dweight=floor(length(vector)/2);
vectorminusdelta=vector-dheight*ones(1,length(vector));
endif

disp('vector size')
size(vector)
disp('dpos')
dpos
disp('zeros(1,dpos-ceil(dweight/2))')
dpos-ceil(dweight/2)
zeros(1,dpos-ceil(dweight/2));
disp('dheight*ones(1,dweight)')
dweight
dheight*ones(1,dweight);
disp('zeros(1,length(vector)-dpos-floor(dweight/2))')
length(vector)-dpos-floor(dweight/2)
zeros(1,length(vector)-dpos-floor(dweight/2));
disp('inside if:')
disp('dpos')
dpos
disp('length vector:')
length(vector)
disp('dweight')
dweight
disp('dpos-ceil(dweight/2)')
dpos-ceil(dweight/2)
disp('length(vector)-dpos-floor(dweight/2)')
length(vector)-dpos-floor(dweight/2)
if (dpos<=length(vector))&&(dweight>=0)&&(dpos>=0)&&(dpos-ceil(dweight/2)>=0)&&(length(vector)-dpos-floor(dweight/2)>=0)
vectorminusdelta=vector-[zeros(1,dpos-ceil(dweight/2)) dheight*ones(1,dweight) zeros(1,length(vector)-dpos-floor(dweight/2))];
ni=find(vectorminusdelta<0);
length(ni);
length(vectorminusdelta);
dheight=dheight-abs(min(vectorminusdelta));
vectorminusdelta(ni)+=3*abs(min(vectorminusdelta))/2;
else
disp('condition on param missed')
endif
endfunction
