function [histpxl header dispersion hmean]=one_spectra

pkg load fits
spectra_folder=uigetdir ("/home/salvicio/", "Directory degli spettri")
#spectra_folder='/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/spectra/';
#cd '/home/salvicio/Documents/astro-shore/AO-CCD-FLAT-SPECTRUM/18102018_astro_obs-20181020T150328Z-001/spectra/';
cd(spectra_folder)
fullfile(spectra_folder,'/*.fits')
files = dir(fullfile(spectra_folder,'/*.fits'));
for i=1:numel({files.name}(:))
try
varname=genvarname(regexprep({files.name}(i),'.fits',''){:})
[histpxl.(varname) header.(varname)]=read_fits_image({files.name}(i){:});
header.(varname)
dispersion.(varname)=transpose(mean(histpxl.(varname),2));
hmean.(varname)=mean(histpxl.(varname),1);
end_try_catch
endfor


#size(histpxl);
cd '~/octave'

#files.name
#read_fits_image({files.name}(1){:});
#fileswerr=[""];
#errorcodes=[];
#try #catchin errors opening files with fitsio
#catch err
#msg = lasterror.message;
#if (strfind (msg, "operator *"))
#number_of_errors++;
#endif
#fileswerr=[fileswerr {files.name}(i)];
#errorcodes=[errorcodes err.identifier];
#err.identifier
#err.message
#class(err.identifier)
#err.identifier
#end_try_catch

#struct_levels_to_print(0)
#function S(a), system(a); endfunction#
#for filefits=fitsfilename
#i
#numel({files.name}(:))
#regexprep({files.name}(i),'.fit',''){:}
#{files.name}(i){:}
#[image.(regexprep({filefits}{:},'.fit','')), header.(regexprep({filefits}{:},'.fit',''))]=read_fits_image(filefits);
