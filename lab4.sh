#! /bin/sh
#Haolun Huang 213813340

if [ $# -eq 0 ]	#if the pathway not specified
then
	printf "Enter your pathway.\n"	#\n to sparate a line
	exit 1				#exit with error code 1
#situation if the file are not reable
else   	readable=`find $1 -perm -o=r -name '*.rec' | wc -l `	#[ ! -r $1/*.rec ] I tried this before but not working	
	if [ $readable -eq 0 ]
	then
	printf "There is not reable *.rec file exits in the specified path or subdirectories.\n"
	exit 1				#exit with error code
	fi

	printf "Enter a command: "	#doesn't need -n for same line typing
	read com

	while [ $com != 'q' -a $com != 'quit' ]		#keep doing inside loop until receving q or quit.
	do
	if [ $com = 'l' -o $com = 'list' ]
	then
		printf "here is the list of found class files\n"
		find $1 -type f -name '*.rec'		#listing all .rec file in the path and subdirs
	elif [ $com = 'ci' ]
	then 
		printf "Found courses are:\n"
		grep ^[A-Z] *.rec | cut -d: -f3 > courseData.txt	#listing start with characters and using cut to extract to txt by two lines.
		while read line ; read line2		#referring to the readfile example on moodle
		do
			echo $line has $line2 credits.
		done < courseData.txt
	elif [ $com = 'sl' ]
	then 	#key is to use uniq to find out all uniq numbers, use cut -c to cut student num part
		printf "Here is the unique list of student numbers in all courses:\n"
		grep ^[0-9] *.rec | cut -d: -f2 | cut -c1-6 | sort | uniq
    	elif [ $com = 'sc' ]
	then 
		count=`grep ^[0-9] *.rec | cut -d: -f2 | cut -c1-6 | sort | uniq | wc -l`
		#using variable to store lines of uniq student numbers
		printf "There are $count registered students in all courses.\n"
	elif [ $com = 'cc' ]
	then 	
		coursecount=`find -name '*.rec' | wc -l`  #same as above using variable to store the count
		printf "There are $coursecount courses files.\n"
	elif [ $com = 'h' -o $com = 'help' ]
	then
		printf "l or list: lists found courses\n"
		printf "ci: gives the name of all courses plus number of credits.\n"
		printf "sl: gives a unique list of all students registered in all courses.\n"
		printf "sc: gives the total number of unique students registered in all courses.\n"
		printf "cc: gives the total numbers of found course files.\n"
		printf "h or help: prints the current message.\n"
		printf "q or quit: exits from the script.\n"
					
	else
		printf "Unrecognized command!\n"
	fi
	printf "command: "			#not end only when q or quit typed.
	read com
	done
	printf "goodbye\n"
fi

