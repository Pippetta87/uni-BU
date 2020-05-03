#This script compare file in Téléchargment with those inside ~/Documents/archivio/
#I'm using md5sum (crc32) but sha256 would be better

function finish {
echo "exiting checksum" >&2
IFS=$oldIFS
}

trap finish EXIT

Tfile=$1
oldIFS=$IFS
IFS=$'\n'

for file in $(ls /home/salvicio/Documents/archivio/**/*.pdf)
do
md5sumfile=$(md5sum $file | awk '{print $1}')
#if [ ! -d ${1}${file} ]; then
if [ -f "$file" ]; then
#if "$(md5sum "$file" | awk '{print $1}')" == "$(md5sum "$Tfile" | awk '{print $1}')";
md5telefile=$(md5sum $Tfile | awk '{print $1}')
#if [ "$md5sumfile"="$md5telefile" ]; then
if [[ "$md5telefile" = "$md5sumfile" ]]; then
zenity --question --title "File già presente!??" --text "In: $file. USCIRE?"
#se rispondo di uscire ritorna exit 2
if [ "$?" == 0 ]; then
echo 2
break
#exit 2
else
echo "0,$md5telefile"
break
#exit 0
fi
    fi
else echo 1
fi
#fine controllo file
done
echo 1
#IFS=$oldIFS

#while read md5sum file
#do
#    matches=$( grep $md5sum md5Boutput.txt )
#    [[ $matches != '' ]] && echo "$file:"$'\n'"$matches"
#done < md5Aoutput.txt
#lento
#find /dir1/ -type f -exec md5sum {} + | sort -k 2 > dir1.txt
#diff -u ~/Documents/archivio/md5sumT.txt ~/Documents/archivio/md5sum.txt | grep "^[^+-]"

#hash1=`md5sum /path/to/file1 | awk '{print $1}'`
#hash2=`md5sum /path/to/file2 | awk '{print $1}'`
#if [ $hash1 -eq $hash2 ]
#then
#echo "Files are the same."
#else
#echo "Files are different."
#fi

#if cmp -s "$oldfile" "$newfile" ; then
#echo "Nothing changed"
#else
#echo "Something changed"
#fi

#diff <(md5 ~/FOLDER1/* | awk '{print $4}') <(md5 ~/FOLDER2/* | awk '{print $4}')
