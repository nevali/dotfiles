ansicolors() {
	for back in 0 40 41 42 43 44 45 46 47 100 101 102 103 104 105 106 107 ; do
		printf "\033[0m%-3d: " $back
		for front in 0 1 2 3 4 5 6 7 ; do
			printf "\033[0m\033[%dm\033[%dm %d \033[0m " $back 3$front $front
		done
		printf "  "
#		printf "\n"
#		printf "\033[0m%-3d: " $back
		for front in 0 1 2 3 4 5 6 7 ; do
			printf "\033[0m\033[%dm\033[%dm %d \033[0m " $back 9$front $front
		done
		printf "\n"
	done
}

alias colours=ansicolors
