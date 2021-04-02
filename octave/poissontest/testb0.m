## Copyright (C) 2021 salvicio
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} testb0 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: salvicio <salvicio@horsepower>
## Created: 2021-01-31

function testb0
top=100;
t=[1,2,3];
k=linspace(0,top,top+1);
mu=22*t;
for i=1:3
p(i)=(find(cumsum(exp(-mu(i)).*(mu(i).^k)./factorial(k))>=0.95))(1)
endfor
disp("what is the exact distribution of score? -sum_i t_i^2+sum_it_ik_i/alpha");
#F(x)=1/2[1+erf(x/(sqrt(2)sigma))]
sa=sum(t.^2)/22;
b=sqrt(0.05/(0.12*1.16))
a=22;
sb=sum(t.^2)/a+b/a^2*sum(t.^3)
la=1.64*sa;
eII=0.5*(1+erf(la/(sqrt(2)*sb)))
#estimation of beta via MLE
kobs=[20,45,76];
LE = @(bpar)-sum(t.^2)+sum(kobs.*t.^2./(a*t+bpar*t.^2));
bpar=fzero(LE,[0,1])
bparv=sum(t.^2/a+bpar*t.^3/a^2)
endfunction
