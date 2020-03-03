#!/bin/bash

Math_Addition () {
	dialog --msgbox "${NUM_ONE} + ${NUM_TWO} = $(expr ${NUM_ONE} + ${NUM_TWO})" 5 50
	Math_Loop
}

Math_Subtraction () {
	dialog --msgbox "${NUM_ONE} - ${NUM_TWO} = $(expr ${NUM_ONE} - ${NUM_TWO})" 5 50
	Math_Loop
}

Math_Multiplication () {
	dialog --msgbox "${NUM_ONE} * ${NUM_TWO} = $(expr ${NUM_ONE} \* ${NUM_TWO})" 5 50
	Math_Loop
}

Math_Division () {
	dialog --msgbox "${NUM_ONE} / ${NUM_TWO} = $(expr ${NUM_ONE} / ${NUM_TWO})" 5 50
	Math_Loop
}

Math_Loop () {
        TRY=$(dialog --stdout --inputbox "Type \"exit\" to Exit" 0 0)

        if [ "$TRY" == exit ]
        then
                echo "Bye!"
                exit 3
        else
                Math_Start
                exit 4
        fi
}

Math_Start () {
	NUM_ONE=$(dialog --stdout --nocancel --inputbox "Enter A Number" 0 50)
	NUM_TWO=$(dialog --stdout --nocancel --inputbox "Enter A Number" 0 50)

	if [ -z "$NUM_ONE" ]
	then
		dialog --msgbox "Insufficient Data to perform Mathematical Operation!" 5 70
		exit 0
	elif [ -z "$NUM_TWO" ]
	then
	        dialog --msgbox "Insufficient Data to perform Mathematical Operation!" 5 70
		exit 1
	fi
	
	OPR=$(dialog --stdout --nocancel --menu "Choose the Mathematical Operation: " 0 50 0 "1" "Addition" "2" "Subtraction" "3" "Multiplication" "4" "Division")
	
	echo $OPR

	case $OPR in
	
		1)
	#		echo "Addition"
			Math_Addition 
			;;		
	
		2)
	#		echo "Subt"
			Math_Subtraction
			;;
	
		3)
	#		echo "mult"
			Math_Multiplication
			;;
	
		4)
	#		echo "Div"
			Math_Division
			;;
	
		*)
			exit 2
			;;
	esac
}


Math_Start

Math_Loop () {
	TRY=$(dialog --stdout --inputbox "Type \"exit\" to Exit" 0 0)
	
	if [ "$TRY" == exit ]
	then
		echo "Bye!"
		exit 3
	else
		Math_Start
		exit 4
	fi
}
