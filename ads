#!/usr/bin/env zsh
########### todo ###########
# install and setup script
########## bugfix ##########
#
############################

echo "THE CURRENT DREAM SUITE IS A NON FUNCTIONING W.I.P. TEST !!! BYE !!!"
echo "Manual configuration should make this program portable and usable on standard *nixes and MacOS, with the following dependencies installed:\n  zsh\n  gettext\n  ffmpeg\nConfiguration steps:\n  1. comment/remove line 10 \"exit 0\"\n  2. $ mkdir ${HOME}/.config/ads\n  3. Move ads_setup, ads.conf, adt.conf, klib.conf, q.conf, template/ to ~/.config/ads\n  4. change lines 11, 17, 20, 36, 39, and 42 of ads.conf to user specification\n  5. make ads executable and call with ./ads\n
exit 1

set -m
setopt ksh_arrays
declare -A c
c[ad]="${HOME}/.config/ads/"
. "${c[ad]}ads.conf"
. "${c[ad]}adt.conf"
. "${c[ad]}klib.conf"

# q keys the main function
q=0
# r selects/deselects function retrying
r=0
# s tracks pending ssh uploads
declare -a s
# w[0] tracks your current room
# w[1+] tracks which rooms you have visited
#	1: bedroom
#	2: living-room
#	3: front-door
#	4: bathroom
#	5: kitchen
w=(0 0 0 0 0 0)
# x tracks misc counters
#	0: EAT
#	1: display link box
#	2-3: counter for connector hotel flavor
#	4: slept
#	5: dishes
x=(0 0 0 0 0)
# names news channels on initialization
n1=($(cat /dev/urandom | env LC_CTYPE=C tr -dc 'BCDFGHJKLMNPRSTVWXYZ' | fold -w 1 | head -n 1) $(cat /dev/urandom | env LC_CTYPE=C tr -dc 'aeiou' | fold -w 1 | head -n 1) $(cat /dev/urandom | env LC_CTYPE=C tr -dc 'bcdfghjklmnpqrstvwxyz' | fold -w 1 | head -n 1))
n1[3]=$(IFS=; echo "${n1[*]} News")
n2=($(cat /dev/urandom | env LC_CTYPE=C tr -dc 'BCDFGHJKLMNPQRSTVWXYZ' | fold -w 1 | head -n 1) $(cat /dev/urandom | env LC_CTYPE=C tr -dc 'BCDFGHJKLMNPQRSTVWXYZ' | fold -w 1 | head -n 1) $(cat /dev/urandom | env LC_CTYPE=C tr -dc 'BCDFGHJKLMNPQRSTVWXYZ' | fold -w 1 | head -n 1))
n2[3]=$(IFS=; echo "${n2[*]}")
# prompt formatting
blq="\033[1;34m"
grq="\033[1;32m"
hlq="\033[43m\033[103m"
noc="\033[0m"
puq="\033[1;35m"
req="\033[1;31m"
stq="\033[1m"
ulq="\033[4m"
whq="\033[1;37m"
yeq="\033[1;33m"
# settings formatting
spcr=$(printf '%0.1s' "."{1..30})
splr=20

# e maintains the main input loop to select functions
function e() {
	[ "${is}" != "1" ] && is
	printf "${stq}Welcome To The American Dream Suite. Unfortunately you will die.${noc} "
	ph
	printf "\n"
	s+=($(cat "${c[ad]}q.conf"))
	printf "" | tee "${c[ad]}q.conf"
	q=1
	rtra=; rtri=;
	while [ "${q}" = "1" ]; do
		printf "\r> "
		read -rsk1 i
		case ${i} in
			${k[quit]%:*}) qf ;;
			${k[makelink]%:*}) mlnk ;;
			${k[makelinkpage]%:*}) mlpg ;;
			${k[makemini]%:*}) mini ;;
			${k[makeminispage]%:*}) mnpg ;;
			${k[mvgifs]%:*}) mvgf ;;
			${k[printhelp]%:*}) ph ;;
			${k[upld]%:*}) upld ;;
			${k[viewqueue]%:*}) vq ;;
			${k[connect]%:*}) cnct ;;
			${k[capmgr]%:*}) cppg ;;
			${k[killcap]%:*}) cpkl ;;
			${k[rtry]%:*}) r=1; [ "${m}" = "B" ] && printf "\n"; bb 23; ${rtri} ;;
			${k[settings]%:*}) sets ;;
			${k[blind]%:*}) blnd ;;
			${k[remlnk]%:*}) rlnk ;;
			${k[BB]%:*}) abbm ;;
			${k[NM]%:*}) arem ;;
			${k[EX]%:*}) aexp ;;
			*) ;;
		esac
	done
}
function bb() {
	if [ "${m}" = "B" ]; then
		printf "\n"
		for l in ${@}; do
			echo "${hlq}$(echo "\xe2\x86\x92 ${a[${l}]}" | fold -sw$(expr ${COLUMNS} - 4) | sed -e "s/ *$//" -e "2,$ s/^/  /" -e "s/$/\\\033\[K/")${noc}"
		done
		printf "\n"
	fi
}
function is() {
	. "${c[ad]}ads_setup"
	echo "The Suite has completed setup. Run it from the command line any time with ${stq}ads${noc}.\n"
	exit 0
}
function kt() {
	case $(ce 5) in
		3) echo "\n  Maybe you are the same" ;;
		4) echo "\n  Suddenly you remember" ;;
		*) ;;
	esac
}
function lv() {
	case $(ce 3) in
		1) echo "and out the window" ;;
		2) echo "to nothing really" ;;
		3) echo "to some framed photos" ;;
	esac
}
function ol() {
	case $(ce 5) in
		1) echo "nothing has changed" ;;
		2) echo "you see them still" ;;
		3) echo "makes you think again" ;;
		4) echo "you hope you will leave another time" ;;
		5) echo "you see it across there" ;;
	esac
}
function pc() {
	printf "Usage:\n  ${ulq}${k[quit]%:*}${noc}:Return\n  ${ulq}${k[Skeybind]%:*}${noc}:${k[Skeybind]#*:}    ${ulq}${k[Skeybnde]%:*}${noc}:${k[Skeybnde]#*:}\n  ${ulq}${k[Spaths]%:*}${noc}:${k[Spaths]#*:}     ${ulq}${k[Ssshcreds]%:*}${noc}:${k[Ssshcreds]#*:}\n"
}
function ph() {
	printf "Usage:\n  ${ulq}${k[quit]%:*}${noc}:${k[quit]#*:}            ${ulq}${k[printhelp]%:*}${noc}:${k[printhelp]#*:}\n  ${ulq}${k[makemini]%:*}${noc}:${k[makemini]#*:}     ${ulq}${k[makeminispage]%:*}${noc}:${k[makeminispage]#*:}\n  ${ulq}${k[makelink]%:*}${noc}:${k[makelink]#*:}     ${ulq}${k[makelinkpage]%:*}${noc}:${k[makelinkpage]#*:}\n  ${ulq}${k[mvgifs]%:*}${noc}:${k[mvgifs]#*:}        ${ulq}${k[connect]%:*}${noc}:${k[connect]#*:}\n  ${ulq}${k[capmgr]%:*}${noc}:${k[capmgr]#*:}      ${ulq}${k[killcap]%:*}${noc}:${k[killcap]#*:}\n  ${ulq}${k[blind]%:*}${noc}:${k[blind]#*:}  ${ulq}${k[remlnk]%:*}${noc}:${k[remlnk]#*:}\n  ${ulq}${k[upld]%:*}${noc}:${k[upld]#*:}          ${ulq}${k[viewqueue]%:*}${noc}:${k[viewqueue]#*:}\n  ${ulq}${k[rtry]%:*}${noc}:${k[rtry]#*:}   ${ulq}${k[settings]%:*}${noc}:${k[settings]#*:}\nDisplay Modes:      ${stq}${ulq}${k[BB]%:*}${noc}:${k[BB]#*:} ${stq}${ulq}${k[NM]%:*}${noc}:${k[NM]#*:} ${stq}${ulq}${k[EX]%:*}${noc}:${k[EX]#*:}\n"
}
function qf() {
	printf "\n"
	if [ ${#s[@]} -eq 0 ]; then
		q=0
	else
		bb 27
		read -sq "yn?Upload queue has items waiting (${#s[@]}). Quit? (y/N) "
		s=($(printf "%s\n" "${s[@]}" | sort -u))
		printf "\n"
		if [ "${yn}" = "y" ]; then
			read -sq "yn?Save queue for next session (y) or abandon? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				printf "Queued items saved to file:\n"
				for i in {0..$(expr ${#s[@]} - 1)}; do
					echo -n "  ${c[ws]}"
					printf "${s[${i}]}\n" | tee -a "${c[ad]}q.conf"
				done
			else
				IFS=$'\n' echo "Items lost from queue:\n$(for i in {0..$(expr ${#s[@]} - 1)}; do echo "  ${c[ws]}${s[${i}]}"; done)"
			fi
			q=0
		fi
	fi
}
function qs() {
	clear
	printf "${stq}Welcome Back To Your Dream.${noc} "
	ph
	p=0
}
function vq() {
	if [ ${#s[@]} -eq 0 ]; then
		echo "Queue is empty"
	else
		s=($(printf "%s\n" "${s[@]}" | sort -u))
		printf "\n"
		for i in {0..$(expr ${#s[@]} - 1)}; do
			IFS=$'\n' echo "  ${c[ws]}${s[${i}]}"
		done
	fi
	bb 24 25
}
function rms() {
	for i in {0..$(expr ${#mv[@]} - 1)}; do
		rmstmp="${mv[${i}]#/}"
		rmstmp2="${rmstmp%/}"
		mv[${i}]="${rmstmp2}"
	done
}
function abbm() {
	if [ "${m}" != "B" ]; then
		printf "\n"
		m="B"
		sed -i '' -e "s/^m=\"[RBE]\"/m=\"B\"/" "${c[ad]}ads.conf"
		[ $? = 0 ] && bb 2 3 4 || echo "Unknown error: could not switch display modes"
	fi
	
}
function aexp() {
	if [ "${m}" != "E" ]; then
		printf "\n"
		m="E"
		sed -i '' -e "s/^m=\"[RBE]\"/m=\"E\"/" "${c[ad]}ads.conf"
		[ $? = 0 ] && echo "Expert mode activated" || echo "Unknown error: could not switch display modes"
	fi
}
function arem() {
	if [ "${m}" != "R" ]; then
		printf "\n"
		m="R"
		sed -i '' -e "s/^m=\"[RBE]\"/m=\"R\"/" "${c[ad]}ads.conf"
		[ $? = 0 ] && echo "Regular mode activated (standard usage helptext)" || echo "Unknown error: could not switch display modes"
	fi
}
function blnd() {
	q=0
	rtri="blnd"
	if [ "${w[0]}" != "1" -a "${w[1]}" != "1" ]; then
		echo "${puq}It is time to sleep$([ "${x[4]}" = "1" ] && echo " again")\n  You walk into the bedroom${noc}"
	elif [ "${w[0]}" != "1" -a "${w[1]}" = "1" ]; then
		echo "${puq}It is time to sleep$([ "${x[4]}" = "1" ] && echo " again")\n  You go back to the bedroom${noc}"
	elif [ "${w[0]}" = "1" -a "${x[4]}" != "1" ]; then
		echo "${puq}You shift around${noc}"
	elif [ "${w[0]}" = "1" -a "${x[4]}" = "1" ]; then
		echo "${puq}Another day without leaving the bed${noc}"
	fi
	bb 38 39 37 33
	echo "    Usage: ${stq}(directories-to-block)${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter path relative to base web dir. Escape spaces in paths.\n    Unnecessary to block access to locations with content pages.\n    Accepts arbitrary arguments."
	blndpg
}
function cnct() {
	q=0
	rtri="cnct"
	if [ "${w[0]}" != "5" -a "${w[5]}" != "1" ]; then
		echo "${whq}Welcome to the kitchen\n  It seems quiet here${noc}"
	elif [ "${w[0]}" != "5" -a "${w[5]}" = "1" ]; then
		echo "${whq}You walk back to the kitchen$([ "$(ct)" = "heads" ] && echo " and go over to the little table")\n  The appliances sitting on the counter look a little out of place${noc}"
	elif [ "${w[0]}" = "5" ]; then
		echo "${whq}Later you could eat something${noc}"
	fi
	bb 48 49 37 33
	echo "    Usage: ${stq}path-to-linking-page path-to-destination-page${noc}"
	[ "${m}" != "E" ] && echo "    Note: Allows creation of links only between internal pages.\n    Add external hyperlinks with cap manager.\n    Enter paths relative to base web dir.\n    ${ulq}/index.htm${noc} not required for pages named as such. Include filename otherwise."
	cnctpg
}
function cpkl() {
	q=0
	rtri="cpkl"
	if [ "${w[0]}" != "5" -a "${w[5]}" != "1" ]; then
		echo "${whq}Welcome to the kitchen\n  It is time to eat${noc}"
	elif [ "${w[0]}" != "5" -a "${w[5]}" = "1" ]; then
		echo "${whq}You walk back to the kitchen\n  Having a meal is not as easy anymore${noc}"
	elif [ "${w[0]}" = "5" -a "${x[0]}" = "1" ]; then
		echo "${whq}It was good${noc}"
	elif [ "${w[0]}" = "5" -a "${x[0]}" != "1" ]; then
		echo "${whq}It in front of you${noc}"
	fi
	bb 40 41 42 37 33
	echo "    Usage: ${stq}directory-path-containing-page${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter path relative to base web dir."
	kllcap
}
function cppg() {
	q=0
	rtri="cppg"
	if [ "${w[0]}" != "5" -a "${w[5]}" != "1" ]; then
		echo "${whq}Welcome to the kitchen\n  The light is soft in this room\n  It is your favorite to be here${noc}"
	elif [ "${w[0]}" != "5" -a "${w[5]}" = "1" ]; then
		echo "${whq}You walk back to the kitchen\n  Even if not every piece seems right\n  Here you find yourself$(kt)${noc}"
	elif [ "${w[0]}" = "5" ]; then
		echo "${whq}It is time to eat soon${noc}"
	fi
	bb 43 44 45 37 33
	echo "    Usage: ${stq}path-containing-page${noc}"
	[ "${m}" != "E" ] && echo "    Note: Enter path relative to base web dir. ${ulq}/index.htm${noc} not required.\n    Each page allows 26 custom images and unlimited external links."
	mkcapp
}
function lnkp() {
	mv=;
	q=1
	w+=([0]=2 [2]=1)
	x[1]=1
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x93\x84") > " mv
	if [ ${#mv[@]} = 0 ]; then
		echo "${blq}  You put the book down${noc}"
		return
	fi
	if [ ${#mv[@]} = 1 ]; then
		mvtm=;
		echo "    Note: not supplying gif will break link chain and display."
		vared -cp "$(echo -ne "\xf0\x9f\x93\x84") > (enter path to gif:) " mvtm
		mv[1]="${mvtm}"
	fi
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 2 ]; then
		rms
		[[ "${mv[1]}" = *.gif ]] || mv[1]="${mv[1]}.gif"
		mv[0]="${mv[0]%index.htm*}"
		if [ ! -f "${c[ws]}${mv[1]}" ]; then
			read -sq "yn?Gif not detected. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				lnkp
			fi
			return
		fi
		if [ ! -f  "${c[ws]}${mv[0]}/index.htm" -a ! -f "${c[ws]}${mv[0]}/index.html" ]; then
			mklpcp
		else
			ovrwrt mklpcp lnkp
		fi
	else
		echo "Input error"
	fi
}
function mini() {
	q=0
	rtri="mini"
	if [ "${w[0]}" != "1" -a "${w[1]}" != "1" ]; then
		echo "${puq}Welcome to the bedroom\n  Your alarm clock is blinking${noc}"
	elif [ "${w[0]}" != "1" -a "${w[1]}" = "1" ]; then
		echo "${puq}You walk back into the bedroom\n  Your alarm clock is blinking${noc}"
	elif [ "${w[0]}" = "1" ]; then
		echo "${puq}Your alarm clock is blinking\n  It is 12:00 still${noc}"
	fi
	bb 57 59 58 60 61 63 37 33
	echo "    Usage: ${stq}infile outfile-name start-time (\"e\"|end-time)${noc}"
	[ "${m}" != "E" ] && echo "    Note: escape spaces in paths. \"e\" for end time specifies end of file."
	mkmini
}
function mlnk() {
	q=0
	rtri="mlnk"
	if [ "${w[0]}" != 2 -a "${w[2]}" = 1 ]; then
		echo "${blq}You walk back into the living room and see the TV\n  $([ "$(ct)" = "heads" ] && echo "${n1[3]}" || echo "${n2[3]}") is playing${noc}"
	elif [ "${w[0]}" != 2 -a "${w[2]}" != 1 ]; then
		echo "${blq}Welcome to the living room\n  You turn on the TV to $([ "$(ct)" = "heads" ] && echo "${n1[3]}" || echo "${n2[3]}")${noc}"
	elif [ "${w[0]}" = 2 ]; then
		echo "${blq}$([ "$(ct)" = "heads" ] && echo "A commercial is flashing" || echo "A report plays softly")${noc}"
	fi
	bb 65 59 58 60 61 63 37 33
	echo "    Usage: ${stq}infile outfile-name [horizontal-width] start-time (\"e\"|end-time)${noc}"
	[ "${m}" != "E" ] && echo "    Note: escape spaces in paths. Default horizontal width is 480.\n\"e\" for end time specifies end of file."
	mklink
}
function mlpg() {
	q=0
	rtri="mlpg"
	if [ "${w[0]}" != "2" -a "${w[2]}" != "1" ]; then
		echo "${blq}Welcome to the living room\n  You pick up a coffee table book at random${noc}"
	elif [ "${w[0]}" != "2" -a "${w[2]}" = "1" ]; then
		echo "${blq}You walk back into the living room\n  You pick up a coffee table book at random${noc}"
	elif [ "${w[0]}" = "2" ]; then
		echo "${blq}You pick up a coffee table book at random${noc}"
	fi
	bb 67 74 75 69 55 37 33
	echo "    Usage: ${stq}path-to-contain-page [path-to-gif]${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter paths relative to base web dir. Gif extension not required."
	[ "${x[1]}" = "0" ] && echo "    ┏━━━━━━━━━┓\n    ┃         ┃\n    ┃   gif   ┃\n    ┃         ┃\n    ┗━━━━━━━━━┛"
	lnkp
}
function mnip() {
	q=1
	mv=;
	mnsz=;
	w+=([0]=1 [1]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x93\x91") > " mv
	if [ ${#mv[@]} = 0 ]; then
		echo "${puq}  You put the book down${noc}"
		return
	elif [ ${#mv[@]} = 1 ]; then
		if [ "${mv[@]}" = "h" ]; then
			echo "${bxh}"
			mnip
			return
		fi
	fi
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 4 ]; then
		rms
		for i in {0..15}; do
			if [ "${mv[0]}${mv[1]}" = "${mszo[${i}]%:*}" ]; then
				mnsz="${i}"
				break
			fi
		done
		if [ -z "${mnsz}" ]; then
			read -sq "yn?Invalid layout. Reenter? (y/N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mnip
			fi
			return
		fi
		if [ -f "${c[at]}${mszo[${mnsz}]%:*}${c[mnpg]}" ]; then
			if [ -d "${c[ws]}${mv[3]}" ]; then
				mngfpg
			else
				read -sq "yn?Directory containing gifs not found. Reenter? (y/N) "
				printf "\n"
				if [ "${yn}" = "y" ]; then
					r=1
					mnip
				fi
				return
			fi
		else
 			echo "Unknown error (minispage file not found)"
		fi
	else
		r=0
		read -sq "yn?Input error. Reenter (y) or abort? (N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			mnip
		fi
		return
	fi
}
function mnpg() {
	q=0
	rtri="mnpg"
	if [ "${w[0]}" != "1" -a "${w[1]}" != "1" ]; then
		echo "${puq}Welcome to the bedroom\n  You pick a random book up off the $([ "$(ct)" = "heads" ] && echo "shelf" || echo "floor")${noc}"
	elif [ "${w[0]}" != "1" -a "${w[1]}" = "1" ]; then
		echo "${puq}You walk back into the bedroom\n  You pick a random book up off the $([ "$(ct)" = "heads" ] && echo "shelf" || echo "floor")${noc}"
	elif [ "${w[0]}" = "1" ]; then
		echo "${puq}You pick up a random book off the $([ "$(ct)" = "heads" ] && echo "shelf" || echo "floor")${noc}"
	fi
	bb 67 68 69 70 55 37 33
	echo "    Usage: ${stq}width height target-path path-containing-gifs${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter paths relative to base web dir.\n    1-4 are accepted for layout width and height values.\n    Layout cannot be 1x1 (use link pages). ${ulq}h${noc} displays options visually."
	mnip
}
function mvgf() {
	q=0
	rtri="mvgf"
	if [ "${w[0]}" != "3" -a "${w[3]}" != "1" ]; then
		echo "${yeq}You stop for a moment at the door$([ "$(ce 4)" = "4" ] && echo "\n  You have some things to do")\n  Looking out the windows $(ol)${noc}"
	elif [ "${w[0]}" != "3" -a "${w[3]}" = "1" ]; then
		echo "${yeq}You stop again at the door$([ "$(ce 6)" = "6" ] && echo "\n  You have some things to do")\n  Looking out the windows $(ol)${noc}"
	elif [ "${w[0]}" = "3" ]; then
		echo "${yeq}Something is tugging at you\n  Looking out the windows $(ol)${noc}"
	fi
	bb 51 52 53 55 37 33
	echo "    Usage: ${stq}target-path (\"cop\"|path-to-gifs) (gif-name(s))${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter path relative to base web dir. Escape spaces in paths\n    Gif extensions not required.\n    Accepts arbitrary input amount (25).\n    \"cop\" uses default gif output dir."
	mvgifs
}
function rlnk() {
	q=0
	rtri="rlnk"
	if [ "${w[0]}" != "5" -a "${w[5]}" != "1" ]; then
		echo "${whq}Welcome to the kitchen\n  Some dishes are piling up from an earlier day\n  Nothing unmanageable${noc}"
	elif [ "${w[0]}" != "5" -a "${w[5]}" = "1" -a "${x[5]}" != "1" ]; then
		echo "${whq}You walk back to the kitchen\n  Some dishes are piling up\n Nothing unmanageable${noc}"
	elif [ "${w[0]}" != "5" -a "${w[5]}" = "1" -a "${x[5]}" = "1" ]; then
		echo "${whq}You walk back to the kitchen\n  The clean sink clears your mind${noc}"
	elif [ "${w[0]}" = "5" -a "${x[5]}" != "1" ]; then
		echo "${whq}They are all right there waiting${noc}"
	elif [ "${w[0]}" = "5" -a "${x[5]}" = "1" ]; then
		echo "${whq}The clean sink clears your mind${noc}"
	fi
	bb 34 35 36 37 33
	echo "    Usage: ${stq}path-to-linking-page${noc}"
	[ "${m}" != "E" ] && echo "    Note: enter path relative to base web dir. Escape spaces in path.\n    ${ulq}/index.htm${noc} not required for pages named as such."
	remlnk
}
function sets() {
	p=1
	q=0
	clear
	echo -n "${stq}ADS Settings${noc} "
	pc
	bb 0 1
	while [ "${p}" = "1" ]; do
		printf "\r$(echo -ne "\xf0\x9f\x9b\xb7") > "
		read -rsk1 i
		case ${i} in
			${k[quit]%:*}) qs ;;
			${k[Skeybnde]%:*}) skyand ;;
			${k[Skeybind]%:*}) skybnd ;;
			${k[Spaths]%:*}) chpths ;;
			${k[Ssshcreds]%:*}) sshcrd ;;
		esac
	done
	q=1
}
function upld() {
	q=0
	rtri="upld"
	if [ "${w[0]}" != 4 ]; then
		echo "${grq}You use the toilet$([ "${w[4]}" = 1 ] && echo " again")${noc}"
	elif [ "${w[0]}" = 4 ]; then
		echo "${grq}You are staying around pretty long${noc}"
	fi
	w+=([0]=4 [4]=1)
	if [ "${#s[@]}" -eq 0 ]; then
		yn=;
	else
		bb 26 28
		read -sq "yn?Upload queue (y) or input manually? (N)"
		printf "\n"
	fi
	if [ "${yn}" = "y" ]; then
		s=($(printf "%s\n" "${s[@]}" | sort -u))
		for i in "${s[@]}"; do
			rsync -vat --exclude=.DS_Store --delete --no-perms --rsync-path="mkdir -p ${c[aw]}/${i} && rsync" "${c[ws]}${i}/" "${c[un]}@${c[us]}:${c[aw]}/${i}"
		done
		[ "${?}" = 0 ] && echo "  ${req}Departed rooms are ready for housekeeping${noc}" || echo "Upload appears to have encountered an error"
		bb 32
		read -sq "yn?Clear upload queue? (y/N) "
		[ "${yn}" = "y" ] && s=()
		printf "\n"
	else
		[ "${#s[@]}" -eq 0 ] && bb 26 28 29 37 33 || bb 29 37 33
		echo "    Usage: ${stq}directory-upload-path(s)${noc}"
		[ "${m}" != "E" ] && echo "    Note: enter paths relative to base web dir. Accepts arbitrary args amount.\n    Local file tree from web dir base matches hosted equivalent."
		mv=;
		if [ "${r}" = "1" ]; then
			mv=(${rtra})
			r=0
		fi
		vared -cap "$(echo -ne "\xe2\x9a\x96\xef\xb8\x8f")  > " mv
		if [ ${#mv[@]} = 0 ]; then
			echo "${grq}  The small fan rattles${noc}"
			q=1
			return
		fi
		rtra="${mv[@]//\ /\\ }"
		rms
		for i in "${mv[@]}"; do
			rsync -vat --exclude=.DS_Store --delete --no-perms --rsync-path="mkdir -p ${c[aw]}/${i} && rsync" "${c[ws]}${i}/" "${c[un]}@${c[us]}:${c[aw]}/${i}"
		done
		[ "${?}" = 0 ] && echo "  ${req}Departed rooms are ready for housekeeping${noc}" || echo "Upload appears to have encountered an error"
	fi
	q=1
}
function blndpg() {
	q=1
	mv=;
	mvc=0
	w+=([0]=1 [1]=1)
	x[4]=1
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x8c\xab")  > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 ]; then
		echo "${puq}  One more night without rest${noc}"
		return
	fi
	rms
	for i in ${mv[@]}; do
		if [ -d "${c[ws]}${i}" ]; then
			if [[ ! -f "${c[ws]}${i}/index.htm" && ! -f "${c[ws]}${i}/index.html" ]]; then
				cp "${c[blpg]}" "${c[ws]}${i}/index.htm"
				blnm="${c[bl]}" envsubst < "${c[ws]}${i}/index.htm" > "${c[ws]}${i}/index.htm.tmp" && mv "${c[ws]}${i}/index.htm.tmp" "${c[ws]}${i}/index.htm"
				x[4]=1
				mvc=1
			else
				pt=;
				for i2 in /index.htm /index.html; do
				[ -f "${c[ws]}${i}${i2}" -a -z "${pt}" ] && pt=$(grep -om1 "Generated by ads\..*:.*\.[0-4]*" "${c[ws]}${i}${i2}")
				done
				pt=${pt##:*}
				if [[ "${pt}" =~ "bl" && "${#mv[@]}" -gt 1 ]]; then
					echo ""
				elif [[ "${pt}" =~ "bl" ]]; then
					echo "Directory ${stq}${i}${noc} already blinded (skipping)"
					continue
				elif [ "${pt%:*}" != "bl" ]; then
					echo "Directory ${stq}${i}${noc} contains content page (skipping)"
				fi
			fi
		else
			read -sq "yn?$([ ${#mv[@]} = 1 ] && echo "Location" || echo "One or more locations") not found. Reenter? (y/N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				blndpg
			fi
			return
		fi
	done
	if [ "${mvc}" = 1 ]; then
		bb 56
		read -sq "yn?Add path$([ "${#mv[@]}" -gt 1 ] && echo "s") to upload queue? (y/N) "
		if [ "${yn}" = "y" ]; then
			for i in ${mv[@]}; do
				s+=("${i}")
			done
			printf "\n"
		else
			mvq=;
			for i in {0..$(expr ${#mv[@]} - 1)}; do
				mvq+="${mv[${i}]}, "
			done
			echo "\nBe advised to safely add ${stq}${mvq%, }${noc}\nto your web host either with provided tool or external program."
		fi
	fi
}
function capext() {
	lnk=;
	nme=;
	printf "\n"
	until [ -n "${lnk}" ]; do
		echo "Enter valid web URL to create outbound link:"
		[ "${m}" != "E" ] && echo "    Note: requires complete protocol (e.g. ${ulq}https://x.x/x${noc}). ${ulq}q${noc} returns."
		vared -cp "$(echo -ne "\xf0\x9f\x96\xbc")  > " lnk
	done
	if [ "${lnk}" = "q" ]; then
		echo "    Usage: ${stq}path-containing-page${noc}"
		r=1
		mkcapp
		return
	fi
	if curl -Ifso /dev/null "${lnk}" 2> /dev/null; then
		until [ -n "${nme}" ]; do
			echo "Enter title to display on page:"
			vared -cp "$(echo -ne "\xf0\x9f\x96\xbc")  > " nme
			if [[ "${nme}" = \$* ]]; then
 				echo "Cap name cannot begin with dollar sign"
 				nme=;
 			fi
		done
		sed -i '' -e "/${c[sk]//\//\\/}/i\ "$'\n'"${c[sp]//\//\\/}" "${c[ws]}${mv[0]}/index.htm"
		capurl="${lnk}" capnme="${nme}" envsubst < "${c[ws]}${mv[0]}/index.htm" > "${c[ws]}${mv[0]}/index.htm.tmp" && mv "${c[ws]}${mv[0]}/index.htm.tmp" "${c[ws]}${mv[0]}/index.htm"
		bb 56
		read -sq "yn?Add path to upload queue? (y/N) "
		if [ "${yn}" = "y" ]; then
				s+=("${mv[0]}")
			printf "\n"
		else
			echo "\nBe advised to safely add ${stq}${mv[0]}${noc} (containing new link)\nto your web host either with provided tool or external program."
		fi
		return
	else
		read -sq "yn?Not found. Reenter? (y/N) "
		if [ "${yn}" = "y" ]; then
			capext
		else
			printf "\n"
		fi
		return
	fi
}
function capint() {
	lnk=;
	nme=;
	dte=;
	for i in {a..z}; do
		grep -q "href=\"${i}.htm\"" "${c[ws]}${mv[0]}/index.htm"
		if [ "${?}" = "1" ]; then
			printf "\n"
			bb 46
			until [ -n "${lnk}" ]; do
 				echo "Enter valid image URL to embed. ${ulq}q${noc} returns."
 				vared -cp "$(echo -ne "\xf0\x9f\x96\xbc")  > " lnk
 			done
 			if [ "${lnk}" = "q" ]; then
				echo "    Usage: ${stq}path-containing-page${noc}"
				r=1
				mkcapp
				return
			fi
 			if curl -Ifso /dev/null "${lnk}" 2> /dev/null; then
 				sed -i '' -e "/${c[sk]//\//\\/}/i\ "$'\n'"${c[sp]//\//\\/}" "${c[ws]}${mv[0]}/index.htm"
 				cp "${c[cppg]}" "${c[ws]}${mv[0]}/${i}.htm"
 				until [ -n "${nme}" ]; do
 					echo "Enter title to display on page:"
 					vared -cp "$(echo -ne "\xf0\x9f\x96\xbc")  > " nme
 					if [[ "${nme}" = \$* ]]; then
 						echo "Cap name cannot begin with dollar sign"
 						nme=;
 					fi
 				done
 				bb 47
 				read -sq "yn?Include date with title? (y/N) "
 				if [ "${yn}" = "y" ]; then
 					printf "\n"
 					until [ -n "${dte}" ]; do
 						echo "Enter date in preferred format:"
 						vared -cp "$(echo -ne "\xf0\x9f\x96\xbc")  > " dte
 					done
					dte="${dte} | "
				else
					printf "\n"
					dte=""
				fi
				capnme="${nme}" capurl="${i}.htm" envsubst < "${c[ws]}${mv[0]}/index.htm" > "${c[ws]}${mv[0]}/index.htm.tmp" && mv "${c[ws]}${mv[0]}/index.htm.tmp" "${c[ws]}${mv[0]}/index.htm"
				capnme="${nme}" capdte="${dte}" capimg="${lnk}" envsubst < "${c[ws]}${mv[0]}/${i}.htm" > "${c[ws]}${mv[0]}/${i}.htm.tmp" && mv "${c[ws]}${mv[0]}/${i}.htm.tmp" "${c[ws]}${mv[0]}/${i}.htm"
				echo "  ${req}New cap inserted onto floor ${(U)i}${noc}"
				bb 56
				read -sq "yn?Add path to upload queue? (y/N) "
				if [ "${yn}" = "y" ]; then
					s+=("${mv[0]}")
					printf "\n"
				else
					echo "\nBe advised to safely add ${stq}${mv[0]}${noc} (containing new link and updated page)\nto your web host either with provided tool or external program."
				fi
				return
 			else
 				read -sq "yn?Not found. Reenter? (y/N) "
 				printf "\n"
				if [ "${yn}" = "y" ]; then
					capint
				fi
				return
 			fi
			break
		fi
	done
	echo "\n  ${req}All floors for internal caps are filled.${noc}\n  To add to this page run the cap remover on one more completely."
}
function caplst() {
	declare -a capdsp
	declare -a capdsp2
	declare -a capdsp3
	capdsp=;
	capdsp2=;
	printf "\n"
	for i in {1..$(grep -c "${c[sn]}" "${c[ws]}${mv[0]}/index.htm")}; do
		capdsp[${i}]="$(grep -m${i} "${c[sn]}" "${c[ws]}${mv[0]}/index.htm" | tail -n1 | sed -e "s/^.*<a[^>]*>//" -e "s/<\/a>.*$//" | sed -e "s/^-->${c[se]//\//\\/} //" -e "s/<\!--$//")"
		capdsp2[${i}]="$(grep -m${i} "${c[sn]}" "${c[ws]}${mv[0]}/index.htm" | tail -n1)"
		capdsp2[${i}]="${capdsp2[${i}]#*href=\"}"
		capdsp2[${i}]="${capdsp2[${i}]%%\"*}"
		[[ $(grep -m${i} "${c[sn]}" "${c[ws]}${mv[0]}/index.htm" | tail -n1) =~ "${c[se]}" ]] && capdsp3[${i}]="0" || capdsp3[${i}]="1"
		[ "${#capdsp2[${i}]}" -gt $((${COLUMNS} - 22)) ] && capdsp2[${i}]="$(echo "${capdsp2[${i}]}" | fold -w$((${COLUMNS} - 12 - $([ ${capdsp3[${i}]} = 0 ] && echo 10 || echo 0))) | head -n1)\033[0m..."
		echo "  ${i}: ${ulq}${capdsp[${i}]}${noc}"
		echo "    $([[ ${capdsp3[${i}]} = "0" ]] && echo "(EXPIRED) ")$([[ "${capdsp2[${i}]}" = [a-z]".htm" ]] && echo "${req}Occupies floor ${(U)capdsp2[${i}]%.htm}${noc}" || echo "\033[47m${capdsp2[${i}]}\033[0m")"
	done
}
function chpths() {
	p1=1
	clear
	echo "${stq}Paths and template options${noc}\nThe following are highly recommended to not edit after setup. User assumes risk!\nAdjust HTML recognition patterns manually in the main config file."
	for i in {1..$(expr ${#cptbnd[@]} - 1)}; do
		echo "  ${ulq}${i}${noc} ${n[${cptbnd[${i}]}]}:"
		echo "    \033[47m${c[${cptbnd[${i}]}]}\033[0m"
	done
	bb 7
	echo "Proceed only if confident. Enter the number of an option to redefine. ${ulq}${k[quit]%:*}${noc} returns."
	until [ "${p1}" = "0" ]; do
		key=;
		vared -cp "$(echo -ne "\xf0\x9f\x94\x92") > " key
		if [ "${key}" = "q" -o -z "${key}" ]; then
			p1=0
			sets
			return
		fi
		for i in {1..$(expr ${#cptbnd[@]} - 1)}; do
			if [ "${i}" = "${key}" ]; then
				valtmp="${c[${cptbnd[${i}]}]}"
				case ${cptbnd[${i}]} in
					ad) bb 18 19 ;;
					op) bb 17 ;;
					ws) bb 16 ;;
					blnd) bb 15 13 ;;
					capp) bb 15 13 ;;
					linp) bb 15 13 ;;
					mnpg) bb 12 13 14 ;;
					bl) bb 8 9 ;;
				esac
				echo "Adjust the selected option:"
				vared -cp "$(echo -ne "\xf0\x9f\x94\x93") > " valtmp
				sed -i '' -e "$(grep -n "c\[${cptbnd[${i}]}\]=" "${c[ad]}ads.conf" | cut -f1 -d:)s/\"${c[${cptbnd[${i}]}]//\//\\/}\"/\"${valtmp//\//\\/}\"/" "${c[ad]}ads.conf"
				. "${c[ad]}ads.conf"
				p1=0
				chpths
				return
			fi
		done
	done
}
function cnctpg() {
	q=1
	mv=;
	w+=([0]=5 [5]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x9a\xaa") > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 ]; then
		echo "${whq}  Dishes are drying${noc}"
		return
	elif [ ${#mv[@]} = 1 ]; then
		read -sq "yn?Missing input. Reenter? (y/N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			cnctpg
		fi
		return
	elif [ ${#mv[@]} -gt 2 ]; then
		read -sq "yn?Too many inputs. Reenter? (y/N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			cnctpg
		fi
		return
	elif [ ${#mv[@]} = 2 ]; then
		rms
		for i in {0..1}; do
			if [[ "${mv[${i}]}" =~ /*.htm* ]]; then
				mv[$(expr ${i} + 2)]="${mv[${i}]##*/}"
				mv[${i}]="${mv[${i}]%/*.htm*}"
			else
				mv[$(expr ${i} + 2)]="index.htm"
			fi
		done
		if [ ! -f "${c[ws]}${mv[0]}/${mv[2]}" ]; then
			read -sq "yn?Page to contain link not found. Reenter (y) or abort? (N) "
			if [ "${yn}" = "y" ]; then
				r=1
				cnctpg
			else
				printf "\n"
			fi
			return
		fi
		if [ ! -f "${c[ws]}${mv[1]}/${mv[3]}" ]; then
			read -sq "yn?Target page not found. Reenter (y) or abort? (N) "
			if [ "${yn}" = "y" ]; then
				r=1
				cnctpg
			else
				printf "\n"
			fi
			return
		fi
		plclnk
	fi
}
function kllcap() {
	q=1
	mv=;
	w+=([0]=5 [5]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xe2\x98\x8e\xef\xb8\x8f")  > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 -a "${x[0]}" != "1" ]; then
		echo "  ${whq}Come on at least have something${noc}"
	elif [ ${#mv[@]} = 0 -a "${x[0]}" = "1" ]; then
		echo "  ${whq}The weather called for it${noc}"
		return
	elif [ ${#mv[@]} = 1 ]; then
		rms
		if [[ "${mv[0]}" = */index.htm* ]]; then
			mv[0]="${mv[0]%/index.htm}"
			mv[0]="${mv[0]%/index.html}"
		fi
		if [ ! -f "${c[ws]}/${mv[0]}/index.htm" ]; then
			read -sq "yn?Page to contain new link not found. Reenter (y) or abort? (N) "
			if [ "${yn}" = "y" ]; then
				kllcap
				return
			else
				printf "\n"
			fi
			return
		else
			grep -q "${c[sn]}" "${c[ws]}/${mv[0]}/index.htm"
			if [ "${?}" = "1" ]; then
				read -sq "yn?No cap links were found. Reenter (y) or abort? (N) "
				if [ "${yn}" = "y" ]; then
					kllcap
				else
					printf "\n"
				fi
				return
			else
				echo "The following cap pages were found:"
				for i in {1..$(grep -c "${c[sn]}" "${c[ws]}${mv[0]}/index.htm")}; do
					mv[${i}]="${i}:$(grep -nm${i} "${c[sn]}" "${c[ws]}${mv[0]}/index.htm" | cut -f1 -d: | tail -n1):$(grep -m${i} "${c[sn]}" "${c[ws]}${mv[0]}/index.htm" | tail -n1 | sed -e "s/^.*<a[^>]*>//" -e "s/<\/a>.*$//" | sed -e "s/^-->${c[se]//\//\\/} //" -e "s/<\!--$//")"
					echo "  $(echo "${mv[${i}]}" | cut -f1 -d:): $(echo "${mv[${i}]}" | cut -f3 -d:)"
				done
				capsel=;
				until [ -n "${capsel}" ]; do
 					echo "Enter the number of the page to expire or remove:"
 					vared -cp "$(echo -ne "\xe2\x98\x8e\xef\xb8\x8f")  > " capsel
 				done
				for i in {1..$(grep -c "${c[sn]}" "${c[ws]}/${mv[0]}/index.htm")}; do
					if [ "${mv[${i}]%%:*}" = "${capsel}" ]; then
						echo "Display expired cap (e) or remove both link and page completely? (r)"
						while :; do
							printf "\r$(echo -ne "\xe2\x98\x8e\xef\xb8\x8f")  > "
							read -rsk1 inp
							case ${inp} in
								e)
									sed "$(echo "${mv[${capsel}]}" | cut -f2 -d:)q;d" "${c[ws]}${mv[0]}/index.htm" | grep -q "${c[se]}"
									if [ "${?}" = 0 ]; then
										printf "\n"
										read -sq "yn?Selected cap appears to already be expired. Reenter (y) or abort? (N) "
										if [ "${yn}" = "y" ]; then
											printf "\n"
											echo "Enter path to directory containing page:" 
											kllcap
											return
										fi
									else
										sed -i '' -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)s/${c[sn]}/&<\!--/" -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)s/<a[^>]*>/&-->${c[se]//\//\\/} /" -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)s/<\/a>/<\!--&-->/" "${c[ws]}/${mv[0]}/index.htm"
										x+=([0]=1 [5]=0)
										break 
									fi ;;
								r)
									mvtm="$(sed -ne "$(echo "${mv[${capsel}]}" | cut -f2 -d:)s/^<\!--[^\"]*\"//" -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)s/\" .*>//p" "${c[ws]}/${mv[0]}/index.htm")"
									printf "\n"
									if [ -f "${c[ws]}${mv[0]}/${mvtm}" ]; then
										printf "Will remove link to page/title/page location without backup.\nProceed (y) or abort? (N) "
										read -sq yn
										printf "\n"
										if [ "${yn}" = "y" ]; then
											sed -i '' -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)d" "${c[ws]}/${mv[0]}/index.htm"
											[ -n "${c[ws]}" ] && rm "${c[ws]}${mv[0]}/${mvtm}"
											if [ "${?}" = "0" ]; then
												echo -n "  ${req}New vacancy on floor ${(U)mvtm%.*}${noc}"
												x+=([0]=1 [5]=0)
											else
												printf "Error removing ${ulq}${mvtm}${noc}\n    Be advised to delete file manually."
											fi
										else
											echo "${whq}When you look at it your appetite goes away${noc}"
											return
										fi
									else
										read -sq "yn?Link and title will be removed. Proceed? (y/N) "
										if [ "${yn}" = "y" ]; then
											sed -i '' -e "$(echo "${mv[${capsel}]}" | cut -f2 -d:)d" "${c[ws]}/${mv[0]}/index.htm"
										fi
									fi
									break ;;
								q)
									read -sq "yn?Abort? (y/N) "
									if [ "${yn}" = "y" ]; then
										printf "\n"
										return
									fi ;;
								*) ;;
							esac
						done
						printf "\n"
						bb 56
						read -sq "yn?Add path to upload queue? (y/N) "
						if [ "${yn}" = "y" ]; then
							s+=("${mv[0]}")
							printf "\n"
						else
							echo "\nCap will be publicly accessible until ${stq}${mv[0]}${noc} is safely updated\non your web host either with provided tool or external program."
						fi
						return
					fi
				done
				read -sq "yn?Invalid input. Reenter (y) or abort? (N) "
				printf "\n"
				if [ "${yn}" = "y" ]; then
					echo "Enter path to directory containing page:"
					kllcap
				fi
			fi
		fi
	elif [ ${#mv[@]} -ge 2 ]; then
		read -sq "yn?Too many inputs. Reenter (y) or abort? (N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			kllcap
		fi
		return
	fi
}
function mkcapp() {
	mv=;
	q=1
	w+=([0]=5 [5]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x96\xbc")  > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 ]; then
		echo "${whq}  You miss something here${noc}"
		return
	elif [ ${#mv[@]} = 1 ]; then
		rms
		if [[ "${mv[0]}" = */index.htm* ]]; then
			mv[0]="${mv[0]%/index.htm*}"
		fi
		if [ ! -f "${c[ws]}/${mv[0]}/index.htm" ]; then
			read -sq "yn?Page to contain new link not found. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mkcapp
			fi
			return
		else
			printf "Create link to external URL (${ulq}e${noc}) or image display page? (${ulq}i${noc})\n"
			[ "$(grep -c "${c[sn]}" "${c[ws]}${mv[0]}/index.htm")" -gt 0 ] && echo "Current caps can be listed with (${ulq}c${noc})"
			while :; do
				printf "\r$(echo -ne "\xf0\x9f\x96\xbc")  > "
				read -rsk1 i
				case ${i} in
					c) if [ "$(grep -c "${c[sn]}" "${c[ws]}${mv[0]}/index.htm")" -gt 0 ]; then
							caplst
							break
						fi ;;
					i) capint; break ;;
					e) capext; break ;;
					q) printf "\n"
						read -sq "yn?Abort? (y/N)"
						printf "\n"
						if [ "${yn}" = "y" ]; then
							return
						fi ;;
					*) ;;
				esac
			done
		fi
	else
		echo "Input error"
		return
	fi
}
function mklink() {
	mv=;
	q=1
	w+=([0]=2 [2]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x93\xba") > " mv
	if [ ${#mv[@]} = 0 ]; then
		echo "${blq}  You look from the tv $(lv)${noc}"
		return
	fi
	rms
	if [ ${#mv[@]} != 4 -a ${#mv[@]} != 5 ]; then
		read -sq "yn?Invalid input. Reenter (y) or abort? (N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			mklink
		fi
		return
	fi
	rtra="${mv[@]//\ /\\ }"
	mv[0]="$(realpath "${mv[0]}")"
	[[ "${mv[1]}" = *.gif ]] || mv[1]="${mv[1]}.gif"
	if [ -f "${c[op]}${mv[1]}" ]; then
		read -sq "yn?File exists in output path. Overwrite? (y/N) "
		printf "\n"
		if [ "${yn}" != "y" ]; then
			echo "Operation cancelled"
			return
		fi
	fi
	if [ ${#mv[@]} = 4 ]; then
		[[ "${mv[2]}" = .* ]] && mv[2]="0${mv[2]}"
		[[ "${mv[3]}" = .* ]] && mv[2]="0${mv[3]}"
		if [[ "${mv[3]}" = [eE] ]]; then
			ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[2]}" -vf scale=480:-1 -r 18 "${c[op]}${mv[1]}"
		elif [[ "${mv[2]}" =~ "^[0-9.:]*$" && "${mv[3]}" =~ "^[0-9.:]*$" ]]; then
			ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[2]}" -to "${mv[3]}" -vf scale=480:-1 -r 18 "${c[op]}${mv[1]}"
		else
			read -sq "yn?Unrecognized time input. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mklink
			fi
			return
		fi
		[ "${?}" = 0 ] && bb 62 66 || echo "The video encoder encountered an error.\033[0m\033[K"
	elif [ ${#mv[@]} = 5 ]; then
		[[ "${mv[3]}" = .* ]] && mv[2]="0${mv[3]}"
		[[ "${mv[4]}" = .* ]] && mv[2]="0${mv[4]}"
		if [[ "${mv[4]}" = [eE] ]]; then
			ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[3]}" -vf scale=${mv[2]}:-1 -r 18 "${c[op]}${mv[1]}"
		elif [[ "${mv[3]}" =~ "^[0-9.:]*$" && "${mv[4]}" =~ "^[0-9.:]*$" ]]; then
			ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[3]}" -to "${mv[4]}" -vf scale=${mv[2]}:-1 -r 18 "${c[op]}${mv[1]}"
		else
			read -sq "yn?Unrecognized time input. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mklink
			fi
			return
		fi
		[ "${?}" = 0 ] && bb 62 66 || echo "The video encoder encountered an error.\033[0m\033[K"
	fi
}
function mklpcp() {
	[ ! -d "${c[ws]}${mv[0]}" ] && mkdir -p "${c[ws]}${mv[0]}"
	cp "${c[lnpg]}" "${c[ws]}${mv[0]}/index.htm"
	gflplk="${c[in]}${mv[1]}" envsubst < "${c[ws]}${mv[0]}/index.htm" > "${c[ws]}${mv[0]}/index.htm.tmp" && mv "${c[ws]}${mv[0]}/index.htm.tmp" "${c[ws]}${mv[0]}/index.htm"
	bb 56
	read -sq "yn?Add path to upload queue? (y/N) "
	if [ "${yn}" = "y" ]; then
		s+=("${mv[0]}")
		printf "\n"
	else
		echo "\nBe advised to safely add ${stq}${mv[0]}${noc} (containing index.htm)\nto your web host either with provided tool or external program."
	fi
	bb 72 73
}
function mkmini() {
	mv=;
	q=1
	w+=([0]=1 [1]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x92\xbd") > " mv
	if [ ${#mv[@]} = 0 ]; then
		echo "${puq}  Nothing occurs these days now${noc}"
		return
	fi
	rtra="${mv[@]//\ /\\ }"
	[[ "${mv[1]}" = *.gif ]] || mv[1]="${mv[1]}.gif"
	[[ "${mv[2]}" = .* ]] && mv[2]="0${mv[2]}"
	[[ "${mv[3]}" = .* ]] && mv[3]="0${mv[3]}"
	if [ -f "${c[op]}${mv[1]}" ]; then
		read -sq "yn?File exists in output path. Overwrite? (y/N) "
		printf "\n"
		if [ "${yn}" != "y" ]; then
			echo "Operation cancelled"
			return
		fi
	fi
	if [ ${#mv[@]} = 4 ]; then
			mv[0]="$(realpath "${mv[0]}")"
			if [[ "${mv[3]}" = [eE] ]]; then
				ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[2]}" -vf "scale=w=256:h=144:force_original_aspect_ratio=decrease,pad=256:144:(ow-iw)/2:(oh-ih)/2" -r 18 "${c[op]}${mv[1]}"
			elif [[ "${mv[2]}" =~ "^[0-9.:]*$" && "${mv[3]}" =~ "^[0-9.:]*$" ]]; then
				ffmpeg -nostdin -hide_banner -loglevel error -y -i "${mv[0]}" -ss "${mv[2]}" -to "${mv[3]}" -vf "scale=w=256:h=144:force_original_aspect_ratio=decrease,pad=256:144:(ow-iw)/2:(oh-ih)/2" -r 18 "${c[op]}${mv[1]}"
			else
				read -sq "yn?Unrecognized time input. Reenter (y) or abort? (N) "
				printf "\n"
				if [ "${yn}" = "y" ]; then
					r=1
					mkmini
				fi
				return
			fi
			[ "${?}" = 0 ] && bb 62 64 || echo "The video encoder encountered an error.\033[0m\033[K"
	else
		read -sq "yn?Invalid input. Reenter (y) or abort? (N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			mkmini
		fi
		return
	fi
}
function mkmncp() {
	[ ! -d "${c[ws]}${mv[2]}" ] && mkdir -p "${c[ws]}${mv[2]}"
	cp "${c[at]}${mszo[${mnsz}]%:*}${c[mnpg]}" "$(realpath "${c[ws]}${mv[2]%/index.*}/index.htm")"
	for i in {0..$(expr ${#gi[@]} - 1)}; do
 		sv="gfmnlk${i}"
		declare "${sv}"="${c[in]}${mv[3]}/${gi[${i}]}"
		export ${sv}
	done
	envsubst < "${c[ws]}${mv[2]%/index.*}/index.htm" > "${c[ws]}${mv[2]%/index.*}/index.htm.tmp" && mv "${c[ws]}${mv[2]%/index.*}/index.htm.tmp" "${c[ws]}${mv[2]%/index.*}/index.htm"
	r=0
	bb 56
	read -sq "yn?Add path to upload queue? (y/N) "
		if [ "${yn}" = "y" ]; then
			s+=("${mv[2]}")
			printf "\n"
		else
			echo "\nBe advised to safely add ${stq}${mv[2]}${noc} (containing index.htm)\nto your web host either with provided tool or external program."
		fi
	bb 72 73
}
function mngfpg() {
	gi=;
	if [ "${r}" = "1" ]; then
		gi=(${rtrl})
		r=0
	fi
	bb 71
	echo "    Usage: ${stq}(gif-names)${noc}\n    ${mszo[${mnsz}]#*:} inputs are necessary for a ${mv[0]}x${mv[1]} layout."
	[ "${m}" != "E" ] && echo "    Note: gif extensions not required."
	if [ "${bx[${mnsz}]}" = 0 ]; then
		echo "${b[${mnsz}]}"
		bx[${mnsz}]=1
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x93\x91") > " gi
	if [ ${#gi[@]} -gt "$(echo ${mszo[${mnsz}]} | cut -f2 -d:)" ]; then
		read -sq "yn?Too many inputs. Reenter? (y/N) "
		printf "\n"
		if [ "${yn}" = "y" ]; then
			r=1
			mngfpg
		fi
		return
	fi
	until [ ${#gi[@]} = "$(echo ${mszo[${mnsz}]} | cut -f2 -d:)" ]; do
		echo "Additional input required ($(expr $(echo ${mszo[${mnsz}]} | cut -f2 -d:) - ${#gi[@]}) more gif$([ $(expr $(echo ${mszo[${mnsz}]} | cut -f2 -d:) - ${#gi[@]}) -gt 1 ] && echo s)):"
		gitm=;
		vared -cap "$(echo -ne "\xf0\x9f\x93\x91") > " gitm
		if [ ${#gitm[@]} -le $(expr $(echo ${mszo[${mnsz}]} | cut -f2 -d:) - ${#gi[@]}) ]; then
			gi+=(${gitm[@]})
		else
			echo "Too many inputs"
		fi
	done
	rtrl="${gi[@]}"
	r=1
	for i in {0..$(expr ${#gi[@]} - 1)}; do
		[[ "${gi[${i}]}" = *.gif ]] || gi[${i}]="${gi[${i}]}.gif"
	done
	for i in "${gi[@]}"; do
		if [ ! -f "${c[ws]}${mv[3]}/${i}" ]; then
			read -sq "yn?One or more gif inputs not found. Reenter? (y/N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				mngfpg
			fi
			return
		fi
	done
	r=0
	if [ ! -f  "${c[ws]}${mv[2]%/index.*}/index.htm" -a ! -f "${c[ws]}${mv[2]%/index.*}/index.html" ]; then
			mkmncp
		else
			ovrwrt mkmncp mnip
		fi
}
function mvgfxa() {
	for mgx0 in {2..$(expr ${#mv[@]} - 1)}; do
		for mgx1 in {a..c} {e..z}; do
			[ ! -f "/${mv[1]}/${mv[${mgx0}]}" ] && break
			if [ ! -f "${c[ws]}${mv[0]}/a${mgx1}.gif" ]; then
				mv -n "/${mv[1]}/${mv[${mgx0}]}" "${c[ws]}${mv[0]}/a${mgx1}.gif"
				continue
			fi
		done
	done
	printf "\n"
	bb 56
	read -sq "yn?Add path to upload queue? (y/N) "
	printf "\n"
	if [ "${yn}" = "y" ]; then
		s+=("${mv[0]}")
	else
		echo "Be advised to safely add ${stq}${mv[0]}${noc} (containing new $([ "${#mv[@]}" -ge 4 ] && echo gifs || echo gif))\nto your web host either with provided tool or external program."
	fi
}
function mvgfxc() {
	for mgx0 in {2..$(expr ${#mv[@]} - 1)}; do
		for mgx1 in {a..z}; do
			[ ! -f "/${mv[1]}/${mv[${mgx0}]}" ] && break
			if [ ! -f "${c[ws]}${mv[0]}/${i}${mgx1}.gif" ]; then
				mv -n "/${mv[1]}/${mv[${mgx0}]}" "${c[ws]}${mv[0]}/${i}${mgx1}.gif"
				continue 1
			fi
		done
	done
	printf "\n"
	bb 56
	read -sq "yn?Add path to upload queue? (y/N) "
	printf "\n"
	if [ "${yn}" = "y" ]; then
		s+=("${mv[0]}")
	else
		echo "Be advised to safely add ${stq}${mv[0]}${noc} (containing new $([ "${#mv[@]}" -ge 4 ] && echo gifs || echo gif))\nto your web host either with provided tool or external program."
	fi
}
function mvgifs() {
	mv=;
	q=1
	w+=([0]=3 [3]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xe2\x9b\x85\xef\xb8\x8f") > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 ]; then
		echo "${yeq}  Your eyes darken briefly${noc}"
		return
	elif [ ${#mv[@]} -ge 27 ]; then
		echo "Too many inputs"
		return
	fi
	if [ "${mv[1]}" = "cop" ]; then
		mv[1]="${c[op]}"
	else
		if [ -d "${mv[1]}" ]; then
			mv[1]="${mv[1]:a}"
		else
			read -sq "yn?Path containing gifs not found. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mvgifs
			fi
			return
		fi
	fi
	rms
	for i in {2..$(expr ${#mv[@]} - 1)}; do
		[[ "${mv[${i}]}" = *.gif ]] || mv[${i}]="${mv[${i}]}.gif"
		if [ ! -f "/${mv[1]}/${mv[${i}]}" ]; then
			read -sq "yn?One or more gif inputs not found. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				mvgifs
			fi
			return
		fi
	done
	[ ! -d "${c[ws]}${mv[0]}" ] && mkdir -p "${c[ws]}${mv[0]}"
	bb 54
	read -sq "yn?Automatically rename by input order? (y/N) "
	if [ "${yn}" = "y" ]; then
		if [ -n "$(find "${c[ws]}${mv[0]}" -maxdepth 1 -mindepth 1 -name "a*.gif" | head -1)" ]; then
			mvrnlp=0;
			for i in {a..c} {e..z}; do
				[ -f "${c[ws]}${mv[0]}/a${i}.gif" ] || ((mvrnlp++))
			done
			if [ "${mvrnlp}" -ge "$(expr ${#mv[@]} - 2)" ]; then
				printf "\n"
				echo -n "${req}Add $([ ${#mv[@]} -gt 3 ] && echo gifs || echo gif) to A Suite?${noc} (y/N) "
				read -sq yn
					if [ "${yn}" = "y" ]; then
						mvgfxa
						return
					else
							printf "\n"
							read -sq "yn?Continue (y) or abort? (N) "
								if [ "${yn}" != "y" ]; then
									printf "\n"
									return
								fi
					fi
			fi
		else
			mvgfxa
			return
		fi
		for i in {b..z}; do
			if [ -n "$(find "${c[ws]}${m[1]}" -maxdepth 1 -mindepth 1 -name "${i}*.gif" | head -1)"]; then
				mvrnlp=0;
				for i2 in {a..z}; do
					[ ! -f "${c[ws]}${mv[0]}/${i}${i2}.gif" ] && ((mvrnlp++))
				done
				if [ "${mvrnlp}" -ge "$(expr "${#mv[@]}" - 2)" ]; then
					echo -n "\n${req}Add gif$([ ${#mv[@]} -gt 3 ] && echo "s") to $(echo ${(U)i}) Suite?${noc} (y/N) "
					read -sq yn
						if [ "${yn}" = "y" ]; then
							mvgfxc
							break
							printf "\n"
						else
							printf "\n"
							read -sq "yn?Continue (y) or abort? (N) "
								if [ "${yn}" != "y" ]; then
									printf "\n"
									return
								fi
						fi
				fi
			else
				mvgfxc
				return
			fi
		done
	else
		for i in {2..$(expr ${#mv[@]} - 1)}; do
			mv -iv "/${mv[1]}/${mv[${i}]}" "${c[ws]}${mv[0]}/${mv[${i}]}"
		done
		bb 56
		read -sq "yn?Add path to upload queue? (y/N) "
			if [ "${yn}" = "y" ]; then
				s+=("${mv[0]}")
				printf "\n"
			else
				echo "\nBe advised to safely add ${stq}${mv[0]}${noc} (containing new gif$([ "${#mv[@]}" -ge 4 ] && echo "s")\nto your web host either with provided tool or external program."
			fi
	fi
}
function ovrwrt() {
	read -sq "yn?Index page exists in given path. Continue (y) or abort? (N) "
	if [ "${yn}" = "y" ]; then
		printf "\n"
		read -sq "yn?Overwrite (y) or reenter? (N) "
		if [ "${yn}" = "y" ]; then
			printf "\n"
			"${1}"
		else
			"${2}"
		fi
	else
		echo "\nOperation cancelled"
	fi
}
function plclnk() {
	pt="$(grep -om1 "Generated by ads\..*:.*\.[0-4]*" "${c[ws]}${mv[0]}/${mv[2]}")"
	pt=${pt##*:}
	if [[ "${pt}" =~ "lp" ]]; then
		if [[ "$(grep -m1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[2]}" | tail -n1)" = *${c[sa]}* ]]; then
			read -sq "yn?This page already contains a link. Reenter (y) or abort? (N) "
			printf "\n"
			if [ "${yn}" = "y" ]; then
				r=1
				cnctpg
			fi
			return
		else
			if [ "${mv[3]}" = "index.htm" ]; then
				mv[3]=;
			else
				mv[3]="/${mv[3]}"
			fi
			mvtm="$(grep -nm1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[2]}" | cut -f1 -d: | tail -n1)"
			sed -i '' -e "${mvtm}s/${c[sl]//\//\\/}/<a href=\"${c[in]//\//\\/}${mv[1]//\//\\/}${mv[3]//\//\\/}\">&/" -e "${mvtm}s/$/<\/a>/" "${c[ws]}${mv[0]}/${mv[2]}"
			echo "  ${req}The suite on this floor is now occupied${noc}"
			read -sq "yn?Add path to upload queue? (y/N) "
			if [ "${yn}" = "y" ]; then
				s+=("${mv[0]}")
				printf "\n"
			else
				echo "\nBe advised to safely add ${stq}${mv[0]}${noc}\nto your web host either with provided tool or external program."
			fi
		fi
	elif [[ "${pt}" =~ "mnsp" ]]; then
		mnsz=;
		echo "${pt}"
		for i in {0..15}; do
			if [[ "${pt#*.}" = "${mszo[${i}]%:*}" ]]; then
				mnsz="${i}"
				break
			fi
		done
		if [ -z "${mnsz}" ]; then
			echo "Unkown error: layout not found"
			return
		fi
		lnkchk=;
		for i in {0..$(expr "${mszo[${mnsz}]#*:}" - 1)}; do
			[[ "$(grep -m$(expr ${i} + 1) "${c[sl]}" "${c[ws]}${mv[0]}/${mv[2]}" | tail -n1)" = *${c[sa]}* ]] && lnkchk[${i}]=1 || lnkchk[${i}]=0
		done
		if [[ ! "${lnkchk[@]}" =~ "0" ]]; then
			read -sq "yn?All possible positions are filled. Reenter (y) or abort? (N) "
			if [ "${yn}" = "y" ]; then
				r=1
				cnctpg
			else
				printf "\n"
			fi
			return
		fi
		for i in {0..$(expr "${mszo[${mnsz}]#*:}" - 1)}; do
			[ "${lnkchk[${i}]}" = 0 ] && mnssel[${i}]="${mnsnum[${i}]#*:}" || mnssel[${i}]="\xc3\x97"
		done
		. "${c[ad]}adt.conf"
		bb 50
		echo "The following positions are available:\n${d[${mnsz}]}"
		q2=(0 0 0 0)
		x+=([2]=0 [3]=0)
		until [ "${q2[0]}" = "1" ]; do
			echo "Enter number of an open position to connect$([ "${q2[1]}" = 0 ] && echo " (${ulq}q${noc} aborts)"):"
			q2[1]="1"
			lnkpos=;
			vared -cp "$(echo -ne "\xf0\x9f\x9a\xaa") > " lnkpos
			if [ "${lnkpos}" = "q" ]; then
				return
			fi
			q2[2]=0
			for i in {0.."$(expr "${mszo[${mnsz}]#*:}" - 1)"}; do
				if [ "$(expr "${i}" + 1)" = "${lnkpos}" ]; then
					q2[2]=1
					if [ "${lnkchk[${i}]}" = 0 ]; then
						if [ "${mv[3]}" = "index.htm" ]; then
							mv[3]=;
						else
							mv[3]="/${mv[3]}"
						fi
						mvtm="$(grep -nm${lnkpos} "${c[sl]}" "${c[ws]}${mv[0]}/${mv[2]}" | cut -f1 -d: | tail -n1)"
						sed -i '' -e "${mvtm}s/${c[sl]//\//\\/}/<a href=\"${c[in]//\//\\/}${mv[1]//\//\\/}${mv[3]//\//\\/}\">&/" -e "${mvtm}s/$/<\/a>/" "${c[ws]}${mv[0]}/${mv[2]}"
						echo "  ${req}Room ${lnkpos} is now occupied${noc}"
						read -sq "yn?Add path to upload queue? (y/N) "
						if [ "${yn}" = "y" ]; then
							s+=("${mv[0]}")
							printf "\n"
						else
							echo "\nBe advised to safely add ${stq}${mv[0]}${noc}\nto your web host either with provided tool or external program."
						fi
						q2[0]="1"
						break 2
					else
						if [ "${x[3]}" -ge 5 ]; then
							echo "  ${req}Can you please stop bothering the guests?${noc}"
						else
							echo "  ${req}This room is already occupied${noc}"
							((x[3]++))
						fi
						break
					fi
				fi
			done
			if [ "${q2[2]}" = 0 ]; then
				if [ "${x[2]}" -ge 5 ]; then
					echo "  ${req}Are you lost? Do you need some help?\n  Are you just having fun?${noc}"
				else
					echo "  ${req}That room is not on this floor${noc}"
					((x[2]++))
				fi
			fi
		done
		return
	elif [[ "${pt}" =~ "cp" ]]; then
		printf "Cap pages link to embedded content and cannot\nbe connected to other internal locations.\nReenter (y) or abort? (N) "
		read -sq "yn"
		if [ "${yn}" = "y" ]; then
			r=1
			cnctpg
		else
			printf "\n"
		fi
		return
	elif [[ "${pt}" =~ "bl" ]]; then
		read -sq "yn?Directory blocking pages are contentless. Reenter (y) or abort? (N) "
		if [ "${yn}" = "y" ]; then
			r=1
			cnctpg
		else
			printf "\n"
		fi
		return
	else
		echo "Page to connect from is not detected to be generated in-program.\nThe included features are too situational to reliably place links otherwise.\nAdd links manually to pages not created by the suite.\nUpload tool may still be used in such circumstances."
	fi
}
function remlnk() {
	q=1
	mv=;
	w+=([0]=5 [5]=1)
	if [ "${r}" = "1" ]; then
		mv=(${rtra})
		r=0
	fi
	vared -cap "$(echo -ne "\xf0\x9f\x8e\xb5") > " mv
	rtra="${mv[@]//\ /\\ }"
	if [ ${#mv[@]} = 0 ]; then
		echo "${whq}  You just look at them${noc}"
		return
	elif [ ${#mv[@]} -gt 1 ]; then
		read -sq "yn?Too many inputs. Reenter (y) or abort? (N) "
		if [ "${yn}" = "y" ]; then
			r=1
			remlnk
		else
			printf "\n"
		fi
		return
	elif [ ${#mv[@]} = 1 ]; then
		rms
		if [[ "${mv[0]}" =~ /*.htm* ]]; then
			mv[1]="${mv[0]##*/}"
			mv[0]="${mv[0]%/*}"
		else
			mv[1]="index.htm"
		fi
		if [ ! -f "${c[ws]}${mv[0]}/${mv[1]}" ]; then
			read -sq "yn?Page not found. Reenter (y) or abort? (N) "
			if [ "${yn}" = "y" ]; then
				r=1
				remlnk
			else
				printf "\n"
			fi
			return
		else
			pt="$(grep -om1 "Generated by ads\..*:.*\.[0-4]*" "${c[ws]}${mv[0]}/${mv[1]}")"
			pt=${pt##*:}
			if [[ "${pt}" =~ "lp" ]]; then
				if [[ "$(grep -m1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | tail -n1)" = *${c[sa]}* ]]; then
					mvtm="$(grep -nm1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | cut -f1 -d: | tail -n1)"
					mvtm2="$(sed -ne "${mvtm}s/${c[sl]}[^>]*>//" -e "${mvtm}s/<\/a>//p" "${c[ws]}${mv[0]}/${mv[1]}" | grep -o "<a .*>" -)"
					mvtm3="${mvtm2#*${c[in]}}"
					mvtm3="${mvtm3%%\"*}"
				else
					read -sq "yn?Page does not appear to contain a link. Reenter (y) or abort? (N) "
					if [ "${yn}" = "y" ]; then
						r=1
						remlnk
					else
						printf "\n"
					fi
					return
				fi
				printf "Will remove a link to ${stq}${mvtm3}${noc}\nProceed (y) or abort? (N) "
				read -sq yn
				printf "\n"
				if [ "${yn}" = "y" ]; then
					sed -i '' -e "${mvtm}s/${mvtm2//\//\\/}//" -e "${mvtm}s/<\/a>//" "${c[ws]}${mv[0]}/${mv[1]}"
					[ "${x[5]}" = 0 ] && echo "  ${whq}It only took a minute${noc}" || echo "  ${whq}Not much to do now${noc}"
					echo "  ${req}New vacancy in the suite${noc}"
					x[5]=1
					bb 56
					read -sq "yn?Add path to upload queue? (y/N) "
					if [ "${yn}" = "y" ]; then
						s+=("${mv[0]}")
						printf "\n"
					else
						echo "\nThe image will be clickable until ${stq}${mv[0]}${noc} is updated\non your web host either with provided tool or external program."
					fi
				fi
				return
			elif [[ "${pt}" =~ "mnsp" ]]; then
				mnsz=;
				for i in {0..15}; do
					if [[ "${pt#*.}" = "${mszo[${i}]%:*}" ]]; then
						mnsz="${i}"
						break
					fi
				done
				if [ -z "${mnsz}" ]; then
					echo "Unkown error: layout not found"
					return
				fi
				lnkchk=;
				for i in {0..$(expr "${mszo[${mnsz}]#*:}" - 1)}; do
					[[ "$(grep -m$(expr ${i} + 1) "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | tail -n1)" = *${c[sa]}* ]] && lnkchk[${i}]=1 || lnkchk[${i}]=0
				done
				if [[ ! "${lnkchk[@]}" =~ "1" ]]; then
					read -sq "yn?No links are detected on this page. Reenter (y) or abort? (N) "
					printf "\n"
					if [ "${yn}" = "y" ]; then
						r=1
						remlnk
					fi
					return
				fi
				for i in {0..$(expr "${mszo[${mnsz}]#*:}" - 1)}; do
					[ "${lnkchk[${i}]}" = 1 ] && mnssel[${i}]="${mnsnum[${i}]#*:}" || mnssel[${i}]="\x20"
				done
				. "${c[ad]}adt.conf"
				echo "The following links can be removed:\n${d[${mnsz}]}"
				q2=(0 0 0 0)
				x+=([2]=0 [3]=0)
				until [ "${q2[0]}" = "1" ]; do
					echo "Enter number of a filled position to remove$([ "${q2[1]}" = 0 ] && echo " (${ulq}q${noc} aborts)"):"
					q2[1]=1
					lnkpos=;
					vared -cp "$(echo -ne "\xf0\x9f\x8e\xb5") > " lnkpos
					if [ "${lnkpos}" = "q" ]; then
						return
					fi
					q2[2]=0
					for i in {0.."$(expr "${mszo[${mnsz}]#*:}" - 1)"}; do
						if [ "$(expr "${i}" + 1)" = "${lnkpos}" ]; then
							q2[2]=1
							if [ "${lnkchk[${i}]}" = 1 ]; then
								mvtm="$(grep -nm${lnkpos} "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | cut -f1 -d: | tail -n1)"
								mvtm2="$(sed -ne "${mvtm}s/<img [^>]*>//" -e "${mvtm}s/<\/a>//p" "${c[ws]}${mv[0]}/${mv[1]}" | grep -o "<a .*>" -)"
								mvtm3="${mvtm2#*${c[in]}}"
								mvtm3="${mvtm3%%\"*}"
								sed -i '' -e "${mvtm}s/<a [^>]*>//" -e "${mvtm}s/<\/a>//" "${c[ws]}${mv[0]}/${mv[1]}"
								[ "${x[5]}" = 0 ] && echo "  ${whq}It only took a minute${noc}" || echo "  ${whq}Not much to do now${noc}"
								echo "  ${req}Room ${lnkpos} has been vacated and cleaned${noc}"
								x[5]=1
								bb 56
								read -sq "yn?Add path to upload queue? (y/N) "
								printf "\n"
								if [ "${yn}" = "y" ]; then
									s+=("${mv[0]}")
								else
									echo "The link to ${stq}${mvtm3}${noc} will be active until ${stq}${mv[0]}${noc} is updated\non your web host either with provided tool or external program."
								fi
								q2[0]="1"
								break 2
							else
								if [ "${x[3]}" -ge 5 ]; then
									echo "  ${req}Can you please stop bothering the guests?${noc}"
								else
									echo "  ${req}This guest is not checking out${noc}"
									((x[3]++))
								fi
								break
							fi
						fi
					done
					if [ "${q2[2]}" = 0 ]; then
						if [ "${x[2]}" -ge 5 ]; then
							echo "  ${req}Are you lost? Do you need some help?\n  Can you get back to it?${noc}"
						else
							echo "  ${req}That room is not on this floor${noc}"
							((x[2]++))
						fi
					fi
				done
			elif [[ "${pt}" =~ "cp" ]]; then
				if [[ "$(grep -m1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | tail -n1)" = *${c[sa]}* ]]; then
					mvtm="$(grep -nm1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | cut -f1 -d: | tail -n1)"
					if [[ "$(grep -m1 "${c[sl]}" "${c[ws]}${mv[0]}/${mv[1]}" | tail -n1)" = *"<!--${c[sa]}"*  ]]; then
						read -sq "yn?Image link already appears to be removed. Reactivate (y) or abort? (N) "
						printf "\n"
						if [ "${yn}" = "y" ]; then
							sed -i '' -e "${mvtm}s/<\!--//g" -e "${mvtm}s/-->//g" "${c[ws]}${mv[0]}/${mv[1]}"
							echo "  ${req}The guest has signaled their room may be cleaned${noc}"
							bb 56
							read -sq "yn?Add path to upload queue? (y/N) "
							printf "\n"
							if [ "${yn}" = "y" ]; then
								s+=("${mv[0]}")
							else
								echo "The image will be clickable until ${stq}${mv[0]}${noc} is updated\non your web host either with provided tool or external program."
							fi
						fi
						return
					else
						read -sq "yn?Displayed image will be visible but not clickable. Proceed (y) or abort? (N) "
						printf "\n"
						if [ "${yn}" = "y" ]; then
							sed -i '' -e "${mvtm}s/${c[sa]}[^>]*>/<\!--&-->/" -e "${mvtm}s/<\/a>/<\!--&-->/" "${c[ws]}${mv[0]}/${mv[1]}"
							echo "  ${req}The guest has hung a do not disturb sign${noc}"
							bb 56
							read -sq "yn?Add path to upload queue? (y/N) "
							printf "\n"
							if [ "${yn}" = "y" ]; then
								s+=("${mv[0]}")
							else
								echo "The image will be clickable until ${stq}${mv[0]}${noc} is updated\non your web host either with provided tool or external program."
							fi
						fi
						return
					fi
				else
					
				fi
			elif [[ "${pt}" =~ "bl" ]]; then
				echo "Directory blocking pages are contentless. There is nothing to remove."
				read -sq "yn?Reenter (y) or abort? (N) "
				printf "\n"
				if [ "${yn}" = "y" ]; then
					r=1
					remlnk
				fi
				return
			else
				printf "Page to disconnect is not detected to be generated in-program.\nThe included features are too situational to reliably adjust links otherwise.\nChange links manually on pages not created by the suite.\nUpload tool may still be used in such circumstances.\nReenter (y) or abort? (N) "
				read -sq yn
				printf "\n"
				if [ "${yn}" = "y" ]; then
					r=1
					remlnk
				fi
				return
			fi
		fi
	fi
}
function sshcrd() {
	p1=1
	clear
	echo "${stq}Internet options${noc}\nThe following should not be edited until targeting new locations online for additional sites. User assumes risk!"
	for i in {1..$(expr ${#cwcbnd[@]} - 1)}; do
		echo "  ${ulq}${i}${noc} ${n[${cwcbnd[${i}]}]}:"
		echo "    \033[47m${c[${cwcbnd[${i}]}]}\033[0m"
	done
	bb 31
	echo "Proceed only if confident. Enter the number of an option to redefine. ${ulq}${k[quit]%:*}${noc} returns."
	until [ "${p1}" = "0" ]; do
		key=;
		vared -cp "$(echo -ne "\xf0\x9f\x94\x92") > " key
		if [ "${key}" = "q" -o -z "${key}" ]; then
			p1=0
			sets
			return
		fi
		for i in {1..$(expr ${#cwcbnd[@]} - 1)}; do
			if [ "${i}" = "${key}" ]; then
				valtmp="${c[${cwcbnd[${i}]}]}"
				case ${cwcbnd[${i}]} in
					un) bb 5 ;;
					us) bb 5 ;;
					in) bb 6 ;;
					aw) bb 10 11 ;;
				esac
				echo "Adjust the selected option:"
				vared -cp "$(echo -ne "\xf0\x9f\x94\x93") > " valtmp
				sed -i '' -e "$(grep -n "c\[${cwcbnd[${i}]}\]=" "${c[ad]}ads.conf" | cut -f1 -d:)s/\"${c[${cwcbnd[${i}]}]//\//\\/}\"/\"${valtmp//\//\\/}\"/" "${c[ad]}ads.conf"
				. "${c[ad]}ads.conf"
				p1=0
				sshcrd
				return
			fi
		done
	done
}
function skyand() {
	p=0
	key=;
	cnflct=0
	keynew=;
	clear
	echo "${stq}Additional keybindings${noc}\nSettings panel"
	for i in ${mstskb[@]}; do
		printf '  %s' "${k[${i}]#*:}"
		printf '%*.*s' 0 $((splr - ${#k[${i}]#*:} - ${#k[${i}]%:*})) "${spcr}"
		echo -n "${ulq}${k[${i}]%:*}${noc}\n"
	done
	echo "Mode switching"
	for i in ${mstmds[@]}; do
		printf '  %s' "${k[${i}]#*:}"
		printf '%*.*s' 0 $((splr - ${#k[${i}]#*:} - ${#k[${i}]%:*})) "${spcr}"
		echo -n "${ulq}${k[${i}]%:*}${noc}\n"
	done
	p=1
	bb 22
	echo "Press any current key to remap to another. Any unbound key returns to menu.\nAccepts any alphanumeric character."
	read -rsk1 "key?$(echo -ne "\xf0\x9f\x8e\x99")  > "
	printf "\n"
	if [[ "${key}" == [A-Za-z0-9] ]]; then
		for i in ${mstskb[@]} ${mstmds[@]}; do
			if [ "${k[${i}]%:*}" = "${key}" ]; then
				read -rsk1 "keynew?Enter a new key for ${k[${i}]#*:}: "
				if [[ "${keynew}" == [A-Za-z0-9] ]]; then
					if [[ "${mstmds[@]%:*}" =~ "${key}" ]]; then
						for i2 in ${mstkbd[@]}; do
							if [ "${k[${i2}]%:*}" = "${keynew}" ]; then
								if [ "${k[${i2}]%:*}" = "${k[${i}]%:*}" ]; then
									skyand
									return
								fi
								printf "\n"
								[ "${i2}" = "quit" ] && bb 21
								echo "${ulq}${keynew}${noc} already bound to ${k[${i2}]#*:}"
								cnflct=1
								break 2
							fi
						done
					fi
					for i2 in ${mstskb[@]} ${mstmds[@]} ${mstkbd[10]}; do
						if [ "${k[${i2}]%:*}" = "${keynew}" ]; then
							if [ "${k[${i2}]%:*}" = "${k[${i}]%:*}" ]; then
								skyand
								return
							fi
							printf "\n"
							[ "${i2}" = "quit" ] && bb 21
							echo "${ulq}${keynew}${noc} already bound to ${k[${i2}]#*:}"
							cnflct=1
							break 2
						fi
					done
					printf "\n"
					sed -i '' -e "$(grep -n "k\[${i}\]" "${c[ad]}ads.conf" | cut -f1 -d:)s/k\[${i}\]=\"${key}/k\[${i}\]=\"${keynew}/" "${c[ad]}ads.conf"
					k[${i}]="${keynew}:${k[${i}]#*:}"
					skyand
					return
				else
					skyand
					return
				fi
			fi
		done
		if [ "${cnflct}" = "1" ]; then
			echo "${stq}ADS Settings${noc} "
			pc
		else
			sets
			return
		fi
	else
		sets
		return
	fi
}
function skybnd() {
	p=0
	key=;
	cnflct=0
	keynew=;
	clear
	echo "${stq}Main keybindings${noc}"
	for i in ${mstkbd[@]}; do
		printf '  %s' "${k[${i}]#*:}"
		printf '%*.*s' 0 $((splr - ${#k[${i}]#*:} - ${#k[${i}]%:*})) "${spcr}"
		echo -n "${ulq}${k[${i}]%:*}${noc}\n"
	done
	p=1
	bb 20
	echo "Press any current key to remap to another. Any unbound key returns to menu.\nAccepts any alphanumeric character."
	read -rsk1 "key?$(echo -ne "\xf0\x9f\x8e\x99")  > "
	printf "\n"
	if [[ "${key}" == [A-Za-z0-9] ]]; then
		for i in ${mstkbd[@]}; do
			if [ "${k[${i}]%:*}" = "${key}" ]; then
				[ "${i}" = "quit" ] && bb 21
				read -rsk1 "keynew?Enter a new key for ${k[${i}]#*:}: "
				if [[ "${keynew}" == [A-Za-z0-9] ]]; then
					if [ "${i}" = "quit" ]; then
						for i2 in ${mstskb[@]} ${mstmds[@]}; do
							if [ "${k[${i2}]%:*}" = "${keynew}" ]; then
								printf "\n"
								echo "${ulq}${keynew}${noc} already bound to ${k[${i2}]#*:}"
								cnflct=1
								break 2
							fi
						done
					fi
					for i2 in ${mstkbd[@]} ${mstmds[@]}; do
						if [ "${k[${i2}]%:*}" = "${keynew}" ]; then
							if [ "${k[${i2}]%:*}" = "${k[${i}]%:*}" ]; then
								skybnd
								return
							fi
							printf "\n"
							echo "${ulq}${keynew}${noc} already bound to ${k[${i2}]#*:}"
							cnflct=1
							break 2
						fi
					done
					printf "\n"
					sed -i '' -e "$(grep -n "k\[${i}\]" "${c[ad]}ads.conf" | cut -f1 -d:)s/k\[${i}\]=\"${key}/k\[${i}\]=\"${keynew}/" "${c[ad]}ads.conf"
					k[${i}]="${keynew}:${k[${i}]#*:}"
					skybnd
					return
				else
					skybnd
					return
				fi
			fi
		done
		if [ "${cnflct}" = "1" ]; then
			echo "${stq}ADS Settings${noc} "
			pc
		else
			sets
			return
		fi
	else
		sets
		return
	fi
}

clear
e
