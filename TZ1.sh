#!/bin/bash


if [ $# -ne 2 ]
then
    	echo "Not enough parameters"
	exit 1
fi


input_dir=$1
output_dir=$2


if [ ! -d "$input_dir" ]
then
    	echo "Input directory not found"
    	exit 1
fi


# если output_dir не существует, создаем его
if [ ! -d "$output_dir" ]
then
    	mkdir -p "$output_dir"
fi


duplicate() {
    	local file="$1"
    	local no_path="${file##*/}"
    	local ext="${no_path##*.}"
    	local file_name="${no_path%.*}"
	local unique_name="$output_dir/$file_name.$ext"
	local end=0

    	# если существует, добавляем _1 или _2 и тд
    	while [ -e "$unique_name" ]
    	do
        	((end++))
        	unique_name="$output_dir/${file_name}_${end}.${ext}"
    	done

    	echo "$unique_name"
}


find "$input_dir" -type f | while read file
do
    	unique_name=$(duplicate "$file")
	cp "$file" "$unique_name"
done


echo "Files copied"
