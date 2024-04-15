#!/usr/bin/env bash

# Ensure that the file is empty. -n is specified to avoid \n which would
# become obvious in the cat in the end.
echo -n '' >employees.csv

# Begin at 0 so the incrementing later makes the first employee id 1.
employees=0

# While the employee name isn't 0, take names.
# neovim again complains about backslash dangling and I will probably never
# type read without -r
while true; do
	echo "Enter employee name or 0 to stop: "
	read -r name

	# stops and breaks out of the loop
	if [ "$name" = "0" ]; then
		break
	fi

	# begin at employee id 1 by incrementing employees from 0
	employee_id=$((employees + 1))

	# store employee_id and name to employees.csv
	# I think tsv would be easier and better, but this is what the task requested.
	echo "$employee_id;$name" >>employees.csv

	# increment employees so the next id will be 2
	employees=$((employees + 1))
done

# and finally print our document. I stand with tsv being better option.
cat employees.csv
