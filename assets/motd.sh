#!/data/data/com.termux/files/usr/bin/bash

picture=(
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠙⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣦⠀⠀⠀⠀⠀⠀"
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠙⢿⣦⡀⠀⠀⠀⢀⣾⡿⠉⣿⡄⠀⠀⠀⠀⠀"
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠙⣿⣄⣠⣴⡿⠋⠀⠀⣿⡇⠀⠀⠀⠀⠀"
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠈⠿⠟⠉⠀⠀⠀⢀⣿⠇⠀⠀⠀⠀⠀"
  "⠀⠀⠀⣿⡿⠿⠿⠿⠷⣶⣾⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣤⣤⣴⣶⣶⡀"
  "⠀⠀⠀⠹⣿⡀⠀⠀⠀⠀⠀⠀⢀⡤⠖⠚⠉⠉⠉⠉⠛⠲⣄⠀⠈⠉⠉⠉⠁⣼⡟⠀"
  "⠀⠀⠀⠀⠹⣷⡀⠀⠀⠀⢀⡔⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡄⠀⠀⢀⣼⡟⠀⠀"
  "⠀⠀⠀⠀⠀⢹⣷⠀⠀⢀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⢠⣾⡏⠀⠀⠀"
  "⠀⢀⣠⣴⡾⠟⠋⠀⠀⣸⠀⠀⠀⣴⣒⣒⣛⣛⣛⣋⣉⣉⣉⣙⣛⣷⠀⠙⠿⣶⣤⡀"
  "⣾⣿⡋⠁⠀⠀⠀⠀⠀⡏⠀⠀⡄⠉⠉⠁⠀⠈⢹⢨⠃⠀⠀⠀⠀⠙⡄⠀⠀⣨⣿⠟"
  "⠈⠛⠿⣷⣦⣀⠀⠀⠀⡇⠀⠸⡟⠛⠿⠛⠛⠛⢻⢿⠋⠹⠟⠉⠉⠙⡇⣠⣾⠟⠁⠀"
  "⠀⠀⠀⢀⣽⣿⠇⠀⠀⡇⠀⠀⠳⣄⣀⠀⣀⣠⠞⠈⢷⣄⣀⣀⣠⣾⠁⢿⣧⡀⠀⠀"
)


a_version=$(getprop ro.build.version.release)
a_brand=$(getprop ro.product.brand)         
a_model=$(getprop ro.product.model)
a_abi=$(getprop ro.product.cpu.abi)

uptime=$(uptime -p)

info=(
  "\e[32m$(whoami)\e[0m@\e[32m$(hostname)\e[0m"
  "------------------------------------"
  "OS:\e[0m Android $a_version $a_abi"
  "Host:\e[0m $a_brand $a_model"
  "Kernel:\e[0m $(uname -r)"
  "Uptime:\e[0m ${uptime:3}"
  "Shell:\e[0m bash $BASH_VERSION"
  "CPU:\e[0m $(grep -m1 'Hardware' /proc/cpuinfo | awk -F ': ' '{print $2}')"
  "RAM:\e[0m $(free -h | awk '/Mem:/ {print "Usada: " $3 " / Total: " $2}')"
)

size="${#picture[@]}"
cols=$(tput cols) 

i=0
while [ $i -lt $size ]; do
  line="\e[34m${picture[$i]}"
  
  text="\e[32m${info[$i]}"

  if [ $cols -gt 75 ]; then
    line+=" $text"
  fi
  
  echo -e "$line"

  ((i++))
done
