function [centroid leftwing]=centroid_width(dispersion,nl)
 #function S(a), system(a); endfunction#

i=1:nl
for j=1:size(fieldnames(dispersion))(1)
try
#centroid (... i ....)= indice del vettore histpxl (posizione da : a [:]
#fieldnames(histpxl)(1:3,1)
#size(histpxl.(fieldnames(histpxl)(1,1){:})) ans =1392   1040
#size(dispersion.(fieldnames(histpxl)(1,1){:})) ans =1   1392
centroid.(fieldnames(dispersion)(j,1){:})=find(dispersion.(fieldnames(dispersion)(j,1){:})([max(1,1+(i-1)*ceil(length(dispersion.(fieldnames(dispersion)(j,1){:}))/nl)):min(i*floor(length(dispersion.(fieldnames(dispersion)(j,1){:}))/nl)-1,length(dispersion.(fieldnames(dispersion)(j,1){:})))])==max(dispersion.(fieldnames(dispersion)(j,1){:})([max(1,(i-1)*floor(length(dispersion.(fieldnames(dispersion)(j,1){:}))/nl)):min(i*ceil(length(dispersion.(fieldnames(dispersion)(j,1){:}))/nl)+1,length(dispersion.(fieldnames(dispersion)(j,1){:})))])))+(i-1)*floor(length(dispersion.(fieldnames(dispersion)(j,1){:}))/nl);
#{
leftwing.(fieldnames(histpxl)(1,1){:})=min(find(histpxl([max(1,(i-1)*ceil(length(histpxl)/nl)):min(length(histpxl),i*ceil(length(histpxl)/nl))])>=max(histpxl([max(1,(i-1)*floor(length(histpxl)/nl)):min
(length(histpxl),i*ceil(length(histpxl)/nl))]))/2))+max(1,(i-1)*floor(length(histpxl)/nl));
#}
catch
warning(lasterror.identifier, lasterror.message)
end_try_catch
#max derivat
endfor
endfunction
#{
[histpxl.(regexprep({files.name}(i),'.fit',''){:}) header.(regexprep({files.name}(i),'.fit',''){:})]=read_fits_image({files.name}(i){:});
header.(regexprep({files.name}(i),'.fit',''){:})
#[image.(regexprep({filefits}{:},'.fit','')), header.(regexprep({filefits}{:},'.fit',''))]=read_fits_image(filefits);
dispersion.(regexprep({files.name}(i),'.fit',''){:})=transpose(mean(histpxl.(regexprep({files.name}(i),'.fit',''){:}),2));
hmean.(regexprep({files.name}(i),'.fit',''){:})=mean(histpxl.(regexprep({files.name}(i),'.fit',''){:}),1);
endfor

struct_levels_to_print(0)
histpxl
#}
