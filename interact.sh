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
  if [[ $char == $'\x1b' ]]; then # arrow key.
    read -r -n2 -s rest
    char+="$rest"
  elif [ "$char" = "" ] ; then # enter. blank
    char="enter"
  elif [ "$char" = "" ] ; then # backspace. zero with non joiner
    char="backspace"
  elif [ "$char" = " " ] ; then # space.
    char="space"
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

    enter )
      echo "enter" ;;

    backspace )
      echo "backspace" ;;

    space )
      echo "space"
      echo -n " " ;;

    * )
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
