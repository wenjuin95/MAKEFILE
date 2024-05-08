#!/bin/bash

FILE="./file_standby.txt"
bonus_input=""
project_input=""
compiler_input=""
path_input=""

function ft_input_the_rest()
{
	while true; do # Check if the user needs bonus input
		read -p "Do you need bonus input? (y/n): " bonus_input
		case $bonus_input in # Check if the user needs bonus input
			[yY]* ) # If the user needs bonus input
				echo -en "CFLAGS = -Wall -Wextra -Werror\n\n" >> $FILE
				echo -en "SRC = \n\n" >> $FILE
				echo -en "BONUS = \n\n" >> $FILE
				echo -en "OBJ_SRC = \$(SRC:.c=.o)\n\n" >> $FILE
				echo -en "OBJ_BONUS = \$(BONUS:.c=.o)\n\n" >> $FILE
				echo -en "all : \$(NAME)\n\n" >> $FILE
				echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
				echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) -o \$@\n\n" >> $FILE
				echo -en "%.o : %.c\n" >> $FILE
				echo -en "\t\$(CC) \$(CFLAGS) -c $< -o \$@\n\n" >> $FILE
				echo -en "clean :\n" >> $FILE
				echo -en "\trm -f \$(OBJ_SRC)\n" >> $FILE
				echo -en "\trm -f \$(OBJ_BONUS)\n\n" >> $FILE
				echo -en "fclean : clean\n" >> $FILE
				echo -en "\trm -f \$(NAME)\n\n" >> $FILE
				echo -en "re : fclean all\n\n" >> $FILE
				echo -en "bonus : \$(OBJ_BONUS)\n" >> $FILE
				echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_BONUS) -o \$@\n\n" >> $FILE
				echo -en ".PHONY: all clean fclean re bonus\n" >> $FILE
				break;;
			[nN]* ) # If the user does not need bonus input
				echo -en "CFLAGS = -Wall -Wextra -Werror\n\n" >> $FILE
				echo -en "SRC = \n\n" >> $FILE
				echo -en "OBJ_SRC = \$(SRC:.c=.o)\n\n" >> $FILE
				echo -en "all : \$(NAME)\n\n" >> $FILE
				echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
				echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) -o \$@\n\n" >> $FILE
				echo -en "%.o : %.c\n" >> $FILE
				echo -en "\t\$(CC) \$(CFLAGS) -c $< -o \$@\n\n" >> $FILE
				echo -en "clean :\n" >> $FILE
				echo -en "\trm -f \$(OBJ_SRC)\n\n" >> $FILE
				echo -en "fclean : clean\n" >> $FILE
				echo -en "\trm -f \$(NAME)\n\n" >> $FILE
				echo -en "re : fclean all\n\n" >> $FILE
				echo -en ".PHONY: all clean fclean re\n" >> $FILE
				break;;
			* )  # If the user inputs an invalid input
				echo "Invalid input. Please answer y or n."
				;;
		esac
	done
}                                 

function ft_check()
{
	while true; do
		if [ -z "$path_input" ]; then
			path_input="./"  # Default path is the current directory
		fi

		if [ -f "$path_input/Makefile" ]; then # Check if Makefile already exists
			echo "Makefile already exists in $path_input"
			exit 1
		else
			if mv file_standby.txt "$path_input/Makefile"; then # Check if the path is valid
				break
			else
				echo "Failed to move Makefile to $path_input. Please check the path and try again."
				read -p "Enter the path again: " path_input
			fi
		fi
	done
}

echo -en " __  __ _____    ____ _____ _   _ _____ ____     _  _____ ___  ____  \n"
echo -en "|  \/  |  ___|  / ___| ____| \ | | ____|  _ \   / \|_   _/ _ \|  _ \ \n"
echo -en "| |\/| | |_    | |  _|  _| |  \| |  _| | |_) | / _ \ | || | | | |_) |\n"
echo -en "| |  | |  _|   | |_| | |___| |\  | |___|  _ < / ___ \| || |_| |  _ < \n"
echo -en "|_|  |_|_|      \____|_____|_| \_|_____|_| \_/_/   \_|_| \___/|_| \_\ \n\n"

touch $FILE

#questions
echo -en "Project name: "
read project_input
echo -en "Compiler: "
read compiler_input

echo -en "NAME = $project_input\n\n" >> $FILE
echo -en "CC = $compiler_input\n\n" >> $FILE
ft_input_the_rest

#questions
echo -en "\rEnter the directory for Makefile? (default: current directory): "
read path_input
ft_check

#animation progress bar
echo -en "Loading..."
sleep 1
echo -en "\r█▒▒▒▒▒▒▒▒▒ 10%" #\r is used to overwrite the previous line
sleep 1
echo -en "\r███▒▒▒▒▒▒▒ 30%"
sleep 1
echo -en "\r█████▒▒▒▒▒ 50%"
sleep 1
echo -en "\r███████▒▒▒ 70%"
sleep 1
echo -en "\r██████████ 100%"
sleep 1
echo -en "\rMakefile created\n"
