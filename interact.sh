#!/bin/bash

cmd=$1
count=0
history=""
statement=""

function cmdline() {
  printf '\r%s' "                                                                      "
  printf '\r%s' ""
  printf '\r%s' "$1"
}

while IFS= read -r -n1 -s char; do # １文字ずつ入力を読む
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

    $'\x1b\x5b\x41' ) # ↑ # read key; echo "$key" | hexdump で確認した
      # 一つ上のhistoryを表示
      (( count++ ))
      cmdline "`echo -ne $history | tail -n $count | head -n1`" ;;

    $'\x1b\x5b\x42' ) # ↓
      if [ $count -gt 0 ] ; then
        (( count-- ))
        cmdline
      fi
      cmdline "`echo -ne $history | tail -n $count | head -n1`" ;;

    $'\x1b\x5b\x43' ) ;; # →

    $'\x1b\x5b\x44' ) ;; # ←

    enter )
      echo ""
      line=$cmd" "$statement
      `echo $line`
      count=0
      history=$history$statement"\n"
      statement="" ;;

    backspace )
      len=$(( ${#statement} - 1 ))
      if [ $len -ge 1 ] ; then
        statement=`echo -ne $statement | cut -c 1-$len`
      elif [ $len -eq 0 ] ; then
        statement=""
      fi
      cmdline "$statement" ;;

    space )
      statement=$statement" "
      cmdline "$statement" ;;

    * )
      statement=$statement$char
      cmdline "$statement" ;;
  esac
done



# read args
# while test "$args" != "a"
# do
#   line=$cmd" "$args
#   `echo $line`
#   read args
# done
