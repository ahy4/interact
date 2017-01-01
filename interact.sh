#!/bin/bash

cmd=$1
count=0
history=""

function cmdline() {
  printf '\r%s' "                                    "
  printf '\r%s' ""
  printf '\r%s' $1
}

while IFS= read -r -n1 -s char; do
  if [[ $char == $'\x1b' ]]; then
    read -r -n2 -s rest
    char+="$rest"
  # elif [ "$char" = "" ] ; then
  #   char="enter"
  # elif [ "$char" = " " ] ; then
  #   char="space"
  # elif [ "$char" = " " ] ; then
  #   char="space"
  fi
  case $char in
    $'\x1b\x5b\x41' ) # ↑  xxd
      # 一つ上のhistoryを表示
      count=`expr $count + 1`
      cmdline `echo -ne $history | tail -n $count | head -n1` ;;
    $'\x1b\x5b\x42' ) # ↓
      if [ $count -gt 0 ] ; then
        count=`expr $count - 1`
        cmdline
      fi
      cmdline `echo -ne $history | tail -n $count | head -n1` ;;
    $'\x1b\x5b\x43' ) ;; # →
    $'\x1b\x5b\x44' ) ;; # ←
    [0-9] )
      echo "cmd"$char &&
      # echo -e "history: "$history &&
      count=0
      history=$history"cmd"$char"\n" ;;
    c )
      cmdline ;;

    * )
      if [ "$char" = "" ] ; then # enter. blank
        echo "enter"
      fi
      if [ "$char" = "" ] ; then # backspace. zero with non joiner
        echo "backspace"
      fi
      if [ "$char" = " " ] ; then # space.
        echo "backspace"
        echo -n " "
      fi

      echo ${#char}
      echo -n $char ;;
  esac
done



# read args
# while test "$args" != "a"
# do
#   line=$cmd" "$args
#   `echo $line`
#   read args
# done
