function vectorminusvoigt=vectorminusvoigt(vector,sigma,gammav,A,offset)
disp('vectorminusvoigt=vectorminusvoigt(vector,sigma,gammav,offset)')
z=(vector+sigma*(1i))/(gammav*sqrt(2));
voigt=A*real(exp(-z.^2).*erfc(-z*(1i)))+offset
disp('vector size')
size(vector)
%if (mu<=length(vector))&&(sigma>=0)&&(mu>=0)&&(mu-ceil(sigma/2)>=0)&&(length(vector)-mu-floor(sigma/2)>=0)
vectorminusvoigt=vector-voigt;
ni=find(vectorminusvoigt<0);
vectorminusvoigt(ni)=0.1*var(vector);
endfunction
