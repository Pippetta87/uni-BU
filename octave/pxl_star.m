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
## @deftypefn {} {@var{retval} =} pxl_star (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: salvicio <salvicio@horsepower>
## Created: 2018-11-14

function [pxl] = pxl_star(nstars,npxl)
##npxl definisce la larghezza della distribuzione di stelle??
## size star distro (R), distance (d) where lens enters?
xy_pxl=randn(nstars,2);
pxl=xy_pxl(:,[1:2])./max(xy_pxl(:,[1:2]))*(npxl/2);
pxl=round(pxl(:,[1:2])-min(pxl(:,[1:2])));
endfunction
