%allineo indici righe spettrali: cerco indici in cui I e' sopra la media in due colonne a +- 5 indici dal centro del lato piu' corto, considero la riga a meta del lato piu' lungo e identifico le intensita' di due righe spettrali di cui cerco l'indice di riga per la colonna 1/2+-5
vl=100
lrshort=20
lcuttip=find(neon(floor(max(size(neon))+1)/2-vl:floor(max(size(neon)+1))/2+vl,floor(min(size(neon)+1)/2)-lrshort)>mean(mean(neon)))%colonna di indici a -5 pixel dal centro del lato minore dove I supera la media
rcuttip=find(neon(floor(max(size(neon))+1)/2-vl:floor(max(size(neon)+1))/2+vl,floor(min(size(neon)+1)/2)+lrshort)>mean(mean(neon)))%colonna di indici a -5 pixel dal centro del lato minore dove I supera la media

%rupoint=find(abs(neon(floor(max(size(neon)+1)/2))-rcuttip(length(rcuttip)/2))<2)
%llpoint=find(abs(neon(floor(min(size(neon))/2-5),:)-lcuttip(length(lcuttip)/2))<2)
