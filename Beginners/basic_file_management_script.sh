#!/bin/bash

while true; do
    echo "=============================="
    echo "         File Management Script  "
    echo "=============================="
    echo "1. Create new files"
    echo "2. Delete existing files"
    echo "3. Update the timestamp of existing files"
    echo "4. Quit"

    read -rp "Please enter the option you want to use: " OPTION

    case $OPTION in
    1)
        read -rp "Do you want to create a single file (1) or multiple files (2)? " CHOICE

        if [[ $CHOICE -eq 1 ]]; then

            read -rp "Enter the filename you want to create: " FILE
            touch "$FILE" && echo "$FILE created."

        elif [[ $CHOICE -eq 2 ]]; then

            read -rp "Do you have a file containing filenames you want to create? (YES or NO): " FILE_CHOICE

            if [[ "$FILE_CHOICE" =~ ^[Yy][Ee][Ss]$ ]]; then

                read -rp "Enter the filename containing the list: " FILE_LIST

                if [[ -f $FILE_LIST ]]; then

                    for file_name in $FILE_LIST; do
                        touch "$file_name"
                    done

                else
                    echo "File not found: $FILE_LIST"
                fi

            else

                read -rp "Enter filenames one by one (separated by space): " -a FILENAMES

                for file_name in "${FILENAMES[@]}"; do
                    touch "$file_name" && echo "$file_name created."
                done

            fi

        else

            echo "Invalid choice. Please enter 1 or 2."

        fi
        ;;

    2)
        read -rp "Do you want to delete single file (1) or multiple files (2)? " CHOICE

        if [[ $CHOICE -eq 1 ]]; then
            read -rp "Please enter the filename you want to delete: " FILENAME
            rm "$FILENAME" && echo "$FILENAME deleted."

        elif [[ $CHOICE -eq 2 ]]; then

            read -rp "Do you have a file containing filenames you want to delete? (YES or NO): " FILE_CHOICE

            if [[ "$FILE_CHOICE" =~ ^[Yy][Ee][Ss]$ ]]; then

                read -rp "Enter the filename containing the list: " FILE_LIST

                if [[ -f $FILE_LIST ]]; then

                    for file_name in $FILE_LIST; do
                        rm "$file_name" && echo "$file_name deleted."
                    done

                else
                    echo "File not found: $FILE_LIST"
                fi

            else

                read -rp "Enter filenames one by one (separated by space): " -a FILENAMES

                for file_name in "${FILENAMES[@]}"; do
                    rm "$file_name" && echo "$file_name deleted."
                done

            fi
        else
            echo "Invalid choice. Please enter 1 or 2."
        fi
        ;;

    3)
        read -rp "Please enter the filenames you want to update timestamps for (separated by space): " -a FILENAMES_TO_UPDATE

        for file_name in "${FILENAMES_TO_UPDATE[@]}"; do

            if [[ -f $file_name ]]; then

                touch "$file_name" && echo "$file_name timestamp updated."

            else

                echo "File not found: $file_name"

            fi

        done
        ;;

    4)
        echo "Exiting..."
        exit 0
        ;;

    *)
        echo "Invalid option, please try again."
        ;;
    esac

done
