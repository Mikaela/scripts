#!/usr/bin/env bash

# Ensure we are given three parameters
if [ $# -ne 3 ]; then
	echo "Please run this script like: ./$0 <operand1> <operator> <operand2>"
	echo "where operator is either +, -, * or /. You may need to escape or"
	echo "single quote it."
	exit 1
fi

# Store the operands and operator
operand1=$1
operator=$2
operand2=$3

# The main case/switch which was required in the exercise
case $operator in
	'+')
		result=$((operand1 + operand2))
		operatorWord="plus"
		;;
	'-')
		result=$((operand1 - operand2))
		operatorWord="minus"
		;;
	'*')
		result=$((operand1 * operand2))
		operatorWord="multiplied by"
		;;
	'/')
		if [ "$operand2" -eq 0 ]; then
			echo "The laws of mathematics don't allow division by zero."
			exit 1
		else
			result=$((operand1 / operand2))
			operatorWord="divided by"
		fi
		;;
	# Let's not forget default case either
	*)
		echo "Please use operator +, -. * or /"
		exit 1
		;;
esac

# and finally the output in format wanted by the task
echo "$operand1 $operatorWord $operand2 equals $result"
