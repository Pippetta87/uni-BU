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

function CI2
top=100;
k=linspace(top,0,top+1);
mus=linspace(0,10,11);
mub=2;
for i=1:11
F=cumsum(exp(-mus(i)-mub).*((mus(i)+mub).^k)./factorial(k));
b(i)=(find(F>=0.9))(1);
endfor
k(b)
b
endfunction
