#! /bin/bash

reset(){
  Arr=(. . . . . . . . .)
  player=1
  gamestatus=1
  echo "	============================="
  echo "		Game started"
}

set(){
  idx=$(( $1 * 3 + $2 ))
  if [ ${Arr[$idx]} == "." ]; then 
    Arr[$idx]=$3
    player=$((player%2+1))
  else
    echo "You can't place there!"
  fi
}

print(){
  echo -e "		    ${Arr[0]}  |    ${Arr[1]}    | ${Arr[2]}"
  echo " 		 ------|---------|------"
  echo -e "		    ${Arr[3]}  |    ${Arr[4]}    | ${Arr[5]}"
  echo " 		 ------|---------|------"
  echo -e "		    ${Arr[6]}  |    ${Arr[7]}    | ${Arr[8]}"
}

checkmatch(){
  if [ ${Arr[$1]} != "." ] && [ ${Arr[$1]} == ${Arr[$2]} ] && [ ${Arr[$2]} == ${Arr[$3]} ]; then
    gamestatus=0
  fi
}

checkgame(){
  checkmatch 0 1 2
  checkmatch 3 4 5
  checkmatch 6 7 8
  checkmatch 0 3 6
  checkmatch 1 4 7
  checkmatch 2 5 8
  checkmatch 0 4 8
  checkmatch 2 4 6
}


reset
 # infinit game loop
while [ 1 == 1 ]; do
  echo ""
  if [ $player == 1 ]; then sym=O
  else sym=X; fi
  echo "Player $player's turn: ($sym)"
  echo -e "\n\n"
  print
  echo ""
  echo -e "\n"
  echo "  Commands:"
  echo "	1. set [row] [column]"
  echo "	2. restart"
  echo "	3. exit "
  while [ 1 == 1 ]; do
    read -r cmd a b
    if [ $cmd == "set" ]; then
  	set $a $b $sym
	break
    elif [ $cmd == "restart" ]; then
	reset
	break
	elif [ $cmd == "exit" ]; then
	exit
    else
	echo "wrong command, try again."
    fi
  done
  checkgame
  if [ $gamestatus != 1 ]; then
    echo "Gameover"
    player=$((player%2+1))
    echo "Player $player ($sym) win!!"
    while [ 1 == 1 ]; do
    	read -r cmd n
    	if [ $cmd == "restart" ]; then
	  reset
	  break
    	fi
    done
  fi
done