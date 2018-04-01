#!/bin/bash
	ARGS=2
	
  dir="/tmp/backups/"
	if [ ! -d "${dir}" ]; 
  then
	mkdir "${dir}"
	fi 
  
  
  if [ "$#" -ne 2 ]; 
  then
	echo "error: Illegal number of parameters" >&2;
	echo "Specify a path to the folder and number of backups" >&2; 
	exit 1
	fi
	
  
	if ! [[ -d $1 ]];
  then
	echo "error: $1 is a not a directory" >&2; 
	exit 1
	fi
	
  
  num='^[0-9]+$'
	if ! [[ $2 =~ $num ]] ;
  then
	echo "error: $2 Not a number" >&2; 
	exit 1
	fi
	
	bdir="${1}"
        bnum="$2"
        bdname=$(echo "${1}" | sed 's/^[/]//' | sed -r 's/[/]/-/g')
        file=${bdname}-$(date '+%Y-%m-%d-%H%M%S').tar.gz


        tar --create --gzip --file="$dir$file" "${bdir}" 2> /dev/null

        rm -f $(find "$dir" -name "${bdname}*" -type f -printf "%Ts\t$dir%P\n" | sort -n | head -n -"$2" | cut -f 2- )


        exit 0

	
