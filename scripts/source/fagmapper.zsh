#!/bin/bash
coursedir=~/Google_Drive/ntnu

function newCourse() {
	change=0
	folders=(ovinger lf kompendier bok annet eksamener eksamensforb) #folders to be created within each course folder.    

	echo "Checking course directory structure.."

	if [ ! -d $coursedir/$1 ]; then
		echo "$1 does not exist, creating directory.."
		mkdir -p $coursedir/$1/
	else
		echo "$1 already exist, checking subdirectories."
	fi

	for folder in $folders; do
		if [ ! -d $coursedir/$1/$folder ]; then	
			mkdir $coursedir/$1/$folder
			echo "- Created $folder in $1."
			change=$((change+1))
		fi
	done
	if [ $change -eq 0 ]; then
		printf "\nThe directory structure for $1 is already up to date!"
	else
		printf "\nThe directory structure for $1 was successfully created!"
	fi
}

function updateAllcourses() {
	for dir in ~/Google\ Drive/ntnu/* ; do
		newCourse $(basename $dir)
	done
}
