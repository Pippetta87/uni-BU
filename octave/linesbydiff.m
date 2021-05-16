difference=diff(neon(:,floor(length(neon)/2)));%derivata discreta del taglio a meta'
linescut=neon(:,floor(length(neon)/2));%taglio a meta'
livello=mean(linescut);%media del taglio a meta'
background=var(linescut(find(linescut<=min(linescut)+20)))
%diffth=find(abs(difference)>150);%valore assoluto della differenza maggiore di una soglia
diffth=find(abs(difference)>150);%valore assoluto della differenza maggiore di una soglia
selections=zeros(length(neon(:,floor(length(neon)/2))),1);%vettore lunghezza dei dati zero ovunque
selections(diffth)+=neon(:,floor(length(neon)/2))(diffth);%tranne che nei punti diffth
diffconseqsign=difference(1:end-1).*difference(2:end);%differenze con segno uguale: positivo
%diffconsegsign=zeros(length(diffsign),1);
diffcp=find(diffconseqsign>0);%differenze con segno positivo consequenziali
diffcn=find(diffconseqsign<=0);%differenze con segno negativo consequenziali
segno=zeros(length(diffconseqsign)+1,1);%inizializzo segno
segno(diffcp+1)+=livello;%segno differenze uguale contiguo (+1)
segno(diffcn+1)-=livello;%segno diverso (-1)
disp('length segno')
length(segno)
disp('length difference')
length(difference)
disp('length linescut')
length(linescut)
disp('length diffth')
length(diffth)
plot(difference)
hold on
plot(diffth,ones(length(diffth),1),'.')
plot(segno)
plot(linescut)


peaker=find(segno>0);%cerco left/right wings come intersezionedifference greater than th e differences with same sign
%wings=
contdiff=diffth(find(diff(diffth)==1));
linesa=peaker(ismember(peaker,contdiff(find(diff(contdiff)>=1))))
linesb=linesa(find(diff(linesa)>1))
npeaker=find(segno<0);
auxdisc=find(diff(linesb)>1);
auxcont=find(diff(linesb)==1);
leftwings(2:length(auxdisc)/2)=linesb(auxdisc(2:2:end-2)+2)
auxcontbetweend=((auxcont<auxdisc(2:2:length(auxdisc))').*(auxcont>auxdisc(1:2:length(auxdisc)-1)'))
[contexist contmin]=max(auxcontbetweend)
sum(auxcontbetweend)
length(sum(auxcontbetweend))
length(conexist)
plot(leftwings,ones(length(leftwings)),'o')
