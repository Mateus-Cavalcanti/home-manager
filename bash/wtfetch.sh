#!/usr/bin/env bash


LIMIT_LINES=10
LIMIT_COLUMNS=80

ASCII_ART=$(cat <<EOF
⠁⡼⠋⠀⣆⠀⠀⣰⣿⣫⣾⢿⣿⣿⠍⢠⠠⠀⠀⢀⠰⢾⣺⣻⣿⣿⣿⣷⡀⠀
⣥⠀⠀⠀⠁⠀⠠⢻⢬⠁⣠⣾⠛⠁⠀⠀⠀⠀⠀⠀⠀⠐⠱⠏⡉⠙⣿⣿⡇⠀
⢳⠀⢰⡖⠀⠀⠈⠀⣺⢰⣿⢻⣾⣶⣿⣿⣶⣶⣤⣤⣴⣾⣿⣷⣼⡆⢸⣿⣧⠀
⠈⠀⠜⠈⣀⣔⣦⢨⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣅⣼⠛⢹⠀
⠀⠀⠀⠀⢋⡿⡿⣯⣭⡟⣟⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⡘⠀
⡀⠐⠀⠀⠀⣿⣯⡿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣉⢽⣿⡆⠀⠀
⢳⠀⠄⠀⢀⣿⣿⣿⣿⣿⣿⣿⠙⠉⠉⠉⠛⣻⢛⣿⠛⠃⠀⠐⠛⠻⣿⡇⠀⠀
⣾⠄⠀⠀⢸⣿⣿⡿⠟⠛⠁⢀⠀⢀⡄⣀⣠⣾⣿⣿⡠⣴⣎⣀⣠⣠⣿⡇⠀⠀
⣧⠀⣴⣄⣽⣿⣿⣿⣶⣶⣖⣶⣬⣾⣿⣾⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⡇⠀⠀
⣿⣶⣈⡯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣹⢧⣿⣿⣿⣄⠙⢿⣿⣿⣿⠇⠀⠀
⠹⣿⣿⣧⢌⢽⣻⢿⣯⣿⣿⣿⣿⠟⣠⡘⠿⠟⠛⠛⠟⠛⣧⡈⠻⣾⣿⠀⠀⠀
⠀⠈⠉⣷⡿⣽⠶⡾⢿⣿⣿⣿⢃⣤⣿⣷⣤⣤⣄⣄⣠⣼⡿⢷⢀⣿⡏⠀⠀⠀
⠀⠀⢀⣿⣷⠌⣈⣏⣝⠽⡿⣷⣾⣏⣀⣉⣉⣀⣀⣀⣠⣠⣄⡸⣾⣿⠃⠀⠀⠀
⠀⣰⡿⣿⣧⡐⠄⠱⣿⣺⣽⢟⣿⣿⢿⣿⣍⠉⢀⣀⣐⣼⣯⡗⠟⡏⠀⠀⠀⠀
⣰⣿⠀⣿⣿⣴⡀⠂⠘⢹⣭⡂⡚⠿⢿⣿⣿⣿⡿⢿⢿⡿⠿⢁⣴⣿⣷⣶⣦⣤
EOF
)

INFO_RAM=$(free -m | awk 'NR==2 {printf "RAM: %s/%s MB\n", $3,$2}')
# INFO_CPU=$(top -bn1 | grep load | awk '{printf "CPU: %.2f%%\n", $(NF-2)}')
INFO_DISK=$(df -h | awk '$NF=="/"{printf "DISK: %d/%d GB\n", $3,$2}')
INFO_USER="USER: $(whoami)"
INFO_CPU=$(cat /proc/cpuinfo | grep 'model name' | cut -d: -f2 | uniq | sed 's/^[ \t]*//')
INFO_OS=$(cat /etc/os-release | grep 'PRETTY_NAME' | cut -d= -f2 | sed 's/^"//' | sed 's/"$//')
INFO_KERNEL=$(uname -r)
INFO_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
INFO_DATE=$(date +"%d/%m/%Y %H:%M:%S")
INFO_HOSTNAME=$(hostname)
INFO_TOTAL_PROCESS=$(ps -e | wc -l)

FIRST_LINE=$(echo "${ASCII_ART}" | head -n 1)
tput setaf 6; echo -e "${FIRST_LINE} - ${INFO_RAM}"
SECOND_LINE=$(echo "${ASCII_ART}" | head -n 2 | tail -n 1)
echo -e "${SECOND_LINE} - ${INFO_CPU}"
THIRD_LINE=$(echo "${ASCII_ART}" | head -n 3 | tail -n 1)
echo -e "${THIRD_LINE} - ${INFO_DISK}"
FOURTH_LINE=$(echo "${ASCII_ART}" | head -n 4 | tail -n 1)
FIFTH_LINE=$(echo "${ASCII_ART}" | head -n 5 | tail -n 1)
echo -e "${FIFTH_LINE} - ${INFO_USER}"
SIXTH_LINE=$(echo "${ASCII_ART}" | head -n 6 | tail -n 1)
echo -e "${SIXTH_LINE} - ${INFO_OS}"
SEVENTH_LINE=$(echo "${ASCII_ART}" | head -n 7 | tail -n 1)
echo -e "${SEVENTH_LINE} - ${INFO_KERNEL}"
EIGHTH_LINE=$(echo "${ASCII_ART}" | head -n 8 | tail -n 1)
echo -e "${EIGHTH_LINE} - ${INFO_DATE}"
NINTH_LINE=$(echo "${ASCII_ART}" | head -n 9 | tail -n 1)
echo "${ASCII_ART}" | tail -n +9
