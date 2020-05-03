#!/bin/sh
case $1 in
  pre)
echo "we are suspending at $(date)..." > /home/salvicio/systemd_suspend_test
bash -c '/usr/bin/i3lock -i "$(~/randfile.sh)"'
  ;;
esac

#!/bin/sh
#if [ "${1}" == "pre" ]; then
# Do the thing you want before suspend here, e.g.:
#exec bash -c '/usr/bin/i3lock -i "$(~/randfile.sh)"'
#echo "we are suspending at $(date)..." > /home/salvicio/systemd_suspend_test
#echo "suspend"
#elif [ "${1}" == "post" ]; then
# Do the thing you want after resume here, e.g.:
#echo "...and we are back from $(date)" >> /tmp/systemd_suspend_test
#fi

