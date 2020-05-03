function [histpxl header]=one_flat
pkg load fits
flats_folder='/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/flats/';
cd '/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/flats/';
files = dir( fullfile(flats_folder,'*.fit') );
for i=1:numel({files.name}(:))
[histpxl.(regexprep({files.name}(i),'.fit',''){:}) header.(regexprep({files.name}(i),'.fit',''){:})]=read_fits_image({files.name}(i){:});
header.(regexprep({files.name}(i),'.fit',''){:})
endfor
cd '~/octave/'
struct_levels_to_print(0)
histpxl
#function S(a), system(a); endfunction#
#for filefits=fitsfilename
#i
#numel({files.name}(:))
#regexprep({files.name}(i),'.fit',''){:}
#{files.name}(i){:}
#[image.(regexprep({filefits}{:},'.fit','')), header.(regexprep({filefits}{:},'.fit',''))]=read_fits_image(filefits);
