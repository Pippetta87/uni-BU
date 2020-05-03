## Copyright (C) 2018 salvicio
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.
## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} pxl_intensity (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn
## Author: salvicio <salvicio@horsepower>
## Created: 2018-11-15

function [mdcv popstar LF]=IMFd(Nstar)
  pkg load statistics

  switch (1)
case 1
#IMF=(m/minmass)^(-2)
#(m,i): somma massa*numero stelle=RV=frazione massa iniziale che ha formato stelle/età cluster
#linspace(mmin,x) vettore lunghezza definita da dm: mtot/mmin??
#->f(m(i))*Nstar
#ndm=round(sqrt(Nstar));
#Intervalloo masse: da 1 (0.08 msun) a 20/0.08 msun 250 -
FF=0.3;#"taglio" dovuto al SNR o fattore geometrico/ range r? 
ndm=250;
#md=linspace(0,1,ndm);#mass interval discretization. Linear
#md=logspace(1,log(1/(2*ndm)),ndm);#mass interval discretization. Log
#mdcv=[0 logspace(-1,1,ndm)(1:end-1)]+diff([0 logspace(-1,1,ndm)/2]);#valori rappresentativi segmento
#mdcv=linspace(0,1,ndm)(1:end-1)+diff(linspace(0,1,ndm)/2);#valori rappresentativi segmento
mdcv=linspace(1,20/0.08,ndm)(1:end-1)+1/ndm;
#sum(10.^(linspace(0,1,1000))-logspace(0,1,1000))=0
#mrp=(md+1/(2*Nstar)).^-2;#relative probability star with given mass
#deltam=diff([0 logspace(-1,1,ndm)]);
deltam=1/ndm;
mrp=(mdcv).^-2;#relative probability star with given mass
prob=mrp/sum(mrp);
starexp=prob*Nstar;
popstar=poissrnd(starexp);
LF=linspace(0,1,ndm);#provvisorio

#0.23(m)^2.3 M<0.43Msun
#m^4: 0.43<m<2
#1.4m^3.5: 2<m<20
#32000m: m>55msun
case 2
  endswitch
 #{come calcolare distribuzione r (o r^2) sapendo che x,y,z sono distribuite uniformemente?
 Quindi (r,theta,phi)?
 Distribuzione di massa: istogramma con larghezza bin deltam e ndm bumero di bin; 
 la probabilità relativa dei bin è inverso quadro della massa: prob per numero di stelle
 mi da conteggio atteso quindi ogni bin di massa ha distro poissoniana con quel conteggio atteso
 (ADS 24/10)
 
 #}
 
endfunction
