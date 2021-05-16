pkg load fits
neonatik='/home/salvicio/octave/ASTROFISICA_OSSERVATIVA_2019/spectral_lamps_ATIK/neon_ATIK.fit';
moon4alpy='/home/salvicio/octave/ASTROFISICA_OSSERVATIVA_2019/alpy_spectra_repository/27 marzo 2018/moon-004.fit';
[neon neonheader]=read_fits_image(neonatik);
[moon004 moon004header]=read_fits_image(moon4alpy);

