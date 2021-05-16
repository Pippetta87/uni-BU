function vectorplusdelta=vectorplusdelta(vector,dpos,dheight,dweight)
disp('vectorplusdelta(vector,dpos,dheight,dweight)')
size(vector)
zeros(1,dpos-ceil(dweight/2))
dheight*ones(1,dweight)
zeros(1,length(vector)-dpos-floor(dweight/2))
vectorplusdelta=vector+[zeros(1,dpos-ceil(dweight/2)) dheight*ones(1,dweight) zeros(1,length(vector)-dpos-floor(dweight/2))]
endfunction
