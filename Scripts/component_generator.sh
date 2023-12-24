#!/bin/bash

create_parent_folder(){
    echo "Do you want to create a folder? [ yes / no ]"
    read ans

    if [[ $ans == 'yes' ]]; then
        echo 'Enter folder name: '
        read

        BASE_FOLDER="$1"

        if [[ -z "$1" ]]; then
            BASE_FOLDER="."
        else
            BASE_FOLDER="./$1"
        fi

        if [[ ! -d "$BASE_FOLDER/$REPLY" ]]; then
            mkdir "$BASE_FOLDER/$REPLY"
        fi

    fi
    return
}

create_files(){
    
    FILES=$(ls ./templates)
    
    if [[ $ans == 'yes' ]]; then
    
        for i in ${FILES[@]}; do

            NAME=$(cat ./templates/$i | grep "name: ".*"" | grep -o "\".*\"" | sed "s/\"/""/g")
            EXT=$(echo $i | sed 's/template//')

            if [[ -z $NAME ]]; then
                sed "s/<>/$REPLY/" "./templates/$i" > $BASE_FOLDER/$REPLY/$REPLY$EXT
            else
                sed "s/<>/$NAME/" "./templates/$i" > $BASE_FOLDER/$REPLY/$NAME$EXT
            fi
        
        done

    fi
    return
}

create_parent_folder
MAIN_FOLDER="$REPLY"
create_files
    
while [[ $ans == 'yes' ]]; do
    create_parent_folder $MAIN_FOLDER
    create_files
done