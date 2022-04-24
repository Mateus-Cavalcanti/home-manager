log_file_output=$1
default_gateway=$(ip route | awk '/default/ { print $3 }')
ping -c 1 $default_gateway > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") true" >> $log_file_output
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") false" >> $log_file_output
fi
