#!/usr/bin/env bash
#
# Password Demonstrator 
#
# Version 1.1
#
# Useful tool to teach how password complexity works with typing
# each character
# 
# Copyright (c) 2022, Michael Shirk
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this 
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, 
# this list of conditions and the following disclaimer in the documentation 
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Requirements:
# Bash
# cracklib-check (a part of the cracklib password checking library)

if [ ! -e /usr/local/sbin/cracklib-check ] && [ ! -e /usr/sbin/cracklib-check ];
then
	echo "Error: requires cracklib library and cracklib-check binary to run"
	echo "Check your UNIX repos"
	exit 13;
	
fi

clear
echo "Instructions: start typing your password as the script will evaluate"
echo "each character to demonstrate password strength and complexity"
echo
echo "NOTE: to echo your password pass this script the verbose flag"
echo
echo -n "Type your password: "

#just loop forever
VALUE=0

VERBOSE=0
NUM="No"
UPPER="No"
LOWER="No"
SPECIAL="No"
LENGTH=0
LONG=0
SHORT=0
PASS=""
SCORE=0
CRKLIB="No"


if [ "$1" == "verbose" ];
then
	VERBOSE=1;
fi

until [ $VALUE = 1 ];
do
	#read -s -N1 VAR
	read -s -e -N1 VAR
	PASS="${PASS}${VAR}"
	LENGTH=${#PASS}
	CRACKLIB=$(echo $PASS | cracklib-check)
	RESULT=$(echo $CRACKLIB | grep "OK" || echo BAD)
	if [[ $PASS =~ [0-9] ]] && [ "$NUM" == "No" ];
	then
		NUM="Yes"
		SCORE="$(($SCORE+1))"
	fi
	if [[ $PASS =~ [A-Z] ]] && [ "$UPPER" == "No" ];
	then
		UPPER="Yes"
		SCORE="$(($SCORE+1))"
	fi
	if [[ $PASS =~ [a-z] ]] && [ "$LOWER" == "No" ];
	then
		LOWER="Yes"
		SCORE="$(($SCORE+1))"
	fi
	if [[ ! $PASS =~ ^[[:alnum:]]+$ ]] && [ "$SPECIAL" == "No" ];
	then
		SPECIAL="Yes"
		SCORE="$(($SCORE+1))"
	fi
	if [ "$RESULT" != "BAD" ] && [ "$CRKLIB" == "No" ];
	then
		SCORE="$(($SCORE+1))"
		CRKLIB="Yes"
	fi
	if [ "$RESULT" == "BAD" ] && [ "$CRKLIB" == "Yes" ];
	then
		SCORE="$(($SCORE-1))"
		CRKLIB="No"
	fi
	if [ "${#PASS}" -le 7 ] && [ "$SHORT" == 0 ];
	then
		SCORE="$(($SCORE-1))"
		SHORT=1
	fi
	if [ "${#PASS}" == 8 ] && [ "$SHORT" == 1 ];
	then
		SCORE="$(($SCORE+1))"
		SHORT=0
	fi
	if [ "${#PASS}" -ge 16 ] && [ "$LONG" == 0 ];
	then
		SCORE="$(($SCORE+1))"
		LONG=1
	fi
	clear
	if [ "$VERBOSE" == "1" ];
	then
		echo "Password: $PASS"
		echo "Cracklib: $CRACKLIB"
	fi
	echo "Length: $LENGTH Number: $NUM UpperCase: $UPPER LowerCase: $LOWER SpecialCharacter: $SPECIAL"
	echo "$SCORE"

	if [ $SCORE -le 1 ];
	then
		echo -e "\e[1;37;4;41mPOOR PASSWORD\e[0m"
	elif [ $SCORE -le 3 ] && [ $SCORE -ge 2 ];
	then
		echo -e "\e[1;37;4;43mNOT SO GREAT PASSWORD\e[0m"

	elif [ $SCORE -le 5 ] && [ $SCORE -ge 4 ];
	then
		echo -e "\e[1;37;4;44mALMOST AN OK PASSWORD\e[0m"

	elif [ $SCORE -ge 6 ];
	then
		echo -e "\e[1;37;4;42mGOOD PASSWORD\e[0m"

	fi
	echo
	echo "Type <Ctrl>+C to exit this script"

done
