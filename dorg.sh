#!/bin/bash
#'': problem when only one directory
#md5sum: maybe prblem with
function finish {
kill -KILL $zpid 2>/dev/null
echo "zthura" $zpido
IFS=$oldIFS
echo "exiting"
}

function finishcheck {
echo "exiting checksum" >&2
IFS=$oldIFS
}

trap finish EXIT

catalog=~/my_file.txt

oldIFS=$IFS
IFS='|'

_term() { 
  echo "Caught SIGTERM signal! $zpid"
  kill -KILL "$zpid" 2>/dev/null
}

#search_dupe () {
#if grep -Fxq "$FILENAME" my_list.txt
#wdiff <(echo "$a") <(echo "$b")
#cmp --silent $old $new
#}
#sorting () {
#
#}
#mkfifo 
#pipe=/tmp/zathura_clip
#trap "rm -f $pipe" EXIT
#if [[ ! -p $pipe ]]
#mkfifo $pipe
#read line <$pipe

checkhash () {
echo "line 42"
#trap finishcheck RETURN
#echo "line 44"
#Tfile=$1
oldIFS=$IFS
IFS=$'\n'
#echo "antefor"
for archived in $(ls /home/salvicio/Documents/tagged\ pdf/**/*.pdf)
do
md5sumfile=$(md5sum $archived | awk '{print $1}')
echo "md5sumfile(Function): $md5sumfile"
#if [ ! -d ${1}${file} ]; then
if [ -f "$archived" ]; then
#if "$(md5sum "$file" | awk '{print $1}')" == "$(md5sum "$Tfile" | awk '{print $1}')";
#if [ "$md5sumfile"="$md5telefile" ]; then
if [[ "$md5telefile" = "$md5sumfile" ]]; then
zenity --question --title "File già presente!??" --text "In: $archived. USCIRE?"
#se rispondo di uscire ritorna exit 2
if [ "$?" == 0 ]; then
echo 2
break
#exit 2
else
echo 0
break
#exit 0
fi
    fi
else echo 1
fi
#fine controllo file
done
echo 1
}

write_meta () {
printf "#%s\n" $filename >> $catalog
printf "%s|%s|%s|%s|%s\n" $meta >> $catalog
printf "%q\n" "$DIR${topath[0]}" >> $catalog
if [ -z "${linktofile[@]}" ]
then
      echo "\$linktofile is empty"
else
      echo "\$linktofile is NOT empty"
printf "%q\n" "${linktofile[@]}" >> $catalog
fi
echo "md5sum to printed at my_file $md5telefile"
#printf "%s\n" "$comments" >> $catalog
printf "md5sum: %s\n" $md5telefile >> $catalog
printf "md5sum: %s\n" $md5telefile
#linktofile+=("$DIR${topath[$i]}")
}

move_file () {
read -r -a meta_array <<< "$meta"
title=${meta_array[0]}
mv "${file}" "${DIR}${topath[0]}${title}.${extension}"
echo "mv: ${DIR}${topath[0]}${title}.${extension}"
#printf "#\n%s|%s|%s|%s\n" $meta >> $catalog
#filename|year|authors|metadata
echo "FIlename: ${meta[0]}"
#printf "%q\n%q\n" "$file" "$DIR${topath[0]}" >> $catalog
#Cartella in cui mv $file
#printf "%q\n" "$DIR${topath[0]}" >> $catalog
echo "$DIR${topath[0]}$title.$extension"
echo "nv: "$nv
#printf "%q\n" "$DIR${topath[0]}$title.$extension"
linktofile=()
for ((i=1;i<=nv-1;i++))
do
#cartelle in cui ln -s il $file
#printf "%q\n" "$DIR${topath[$i]}" >> $catalog
linktofile+=("$DIR${topath[$i]}")
echo "linktofile: ${linktofile[@]}"
ln -s "${DIR}${topath[0]}${title}.${extension}" "${DIR}${topath[$i]}${title}.${extension}"
echo "$i"
done
}

#funtion arguments -> filename to comapre against curr time
function comparedate() {
if [ ! -f $1 ]; then
  echo "file $1 does not exist"
	exit 1
fi
MAXAGE=$(bc <<< '5*60') # seconds in 5 minutes
# file age in seconds = current_time - file_modification_time.
FILEAGE=$(($(date +%s) - $(stat -c '%Y' "$1")))
test $FILEAGE -lt $MAXAGE && {
    echo "$1 is less than 5 minutes old."
    return 0
}
echo "$1 is older than 5 minutes."
return 1
}
#Current=`date +%b%e`
#Filepmdate=`ls -l my_file.txt | awk '{print $6,$7}'`
#touch -t $(date --date=yesterday +%Y%m%d%H%M.%S) $STAMPFILE
#if [ $PIDFILE -ot $STAMPFILE ]; then


#take first pdf from Télechargement:
file=$(ls -t ~/Téléchargements/*.pdf | head -1)
extension="${file##*.}"
filename=$(basename -- "$file")
#extension="${filename##*.}"
#filename="${filename%.*}"
#alternative
#filename="${fullfile##*/}"
echo "line 144"
### DEVO RETURNARE md5telefile
md5telefile=$(md5sum $file | awk '{print $1}')
chreturn=$(checkhash)
if [[ $(comparedate $file) ]]; then
echo "older"
#open pdf file in zathura
zenity --info --text "Check all classes are present"
exec $(zathura "$file")
zpid=$!
#wait
echo "md5 telefile: $md5telefile"
echo "cecho $chreturn"
#compare checksum with files (not symlinks) in archivio
if [ $chreturn -gt 1 ]; then
exit 2
fi
exec $(zathura "$file" > /dev/null)&
zpid=$!
else
echo "new"
exec $(zathura "$file" > /dev/null)&
zpid=$!
fi

DIR=/home/salvicio/Documents/tagged\ pdf/
cd $DIR
classes=(*/)
#checklist=()
n=${#classes[@]}
for ((i=0;i<=n-1;i++))
do
##
checklist[2*$i]=FALSE
echo "\""${classes[$i]}"\""
checklist[2*$i+1]="${classes[$i]}"
##FILENAME="$(printf %q "$FILENAME")"
#checklist+="FALSE "$(echo ${classes[$i]} | sed -e 's/\/$/\"'" /' -e 's/^/\"'"/')
#checklist+="FALSE "$(echo "${classes[$i]}" | sed -e 's/\/$/ /' -e 's/\s/\\ /')
#FLAGS=(--archive --exclude="foo bar.txt")
#rsync "${FLAGS[@]}" dir1 dir2
#IFS=$(echo -en "\n\b")
#/usr/bin/beep-media-player "$(cat  $@)" &
#printf "%s\n" */
#sed -e 's/ /\\ /g'
done
#echo "Checklist: ${checklist[@]}"
classified=$(zenity --list --text "File: $file" --checklist  --column "Pick" --column "where" "${checklist[@]}")
if [[ $? == 1 ]]
then
exit
fi
read -r -a topath <<< "$classified"
echo "to path [0]: ${topath[0]}"
nv=${#topath[@]}
#zenity --question --text "Classified: $classified"
#zenity --question --text "$DIR""${topath[0]}"
meta="$(zenity --forms --title="Title and info" --add-entry="Title" --add-entry="year" --add-entry="Authors" --add-entry="Meta" --add-entry="Comments")"
#echo "Meta: $meta"
if [[ $? == 1 ]]
then
exit
fi

#read -r -a meta_array <<< "$meta"
#echo "${meta_array[1]}"
#meta_array: title|year|authors|meta
#IFS=$oldIFS
#echo "${meta_array[@]}"
#zenity --question --text "${meta_array[1]}"
#zenity --question --text "$meta \n ${topath[@]}"

move_file
write_meta

exit 0


#unset checklist
#unset classified
