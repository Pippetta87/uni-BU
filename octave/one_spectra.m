function [histpxl header dispersion hmean]=one_spectra

pkg load fits
spectra_folder='/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/spectra/';
cd '/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/spectra/';
files = dir( fullfile(spectra_folder,'*.fit') );
for i=1:numel({files.name}(:))
[histpxl.(regexprep({files.name}(i),'.fit',''){:}) header.(regexprep({files.name}(i),'.fit',''){:})]=read_fits_image({files.name}(i){:});
header.(regexprep({files.name}(i),'.fit',''){:})
dispersion.(regexprep({files.name}(i),'.fit',''){:})=transpose(mean(histpxl.(regexprep({files.name}(i),'.fit',''){:}),2));
hmean.(regexprep({files.name}(i),'.fit',''){:})=mean(histpxl.(regexprep({files.name}(i),'.fit',''){:}),1);
endfor

struct_levels_to_print(0)
histpxl
cd '~/octave'

#function S(a), system(a); endfunction#
#for filefits=fitsfilename
#i
#numel({files.name}(:))
#regexprep({files.name}(i),'.fit',''){:}
#{files.name}(i){:}
#[image.(regexprep({filefits}{:},'.fit','')), header.(regexprep({filefits}{:},'.fit',''))]=read_fits_image(filefits);
