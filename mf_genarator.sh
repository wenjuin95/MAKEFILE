#!/bin/bash

# color
GREEN="\033[0;32m"
RESET="\033[0m"
RED="\033[0;31m"

FILE="Makefile"
bonus_input=""
project_input=""
compiler_input=""
path_input=""

function ft_cpp_makefile()
{
	echo -en "NAME = $project_input\n\n" >> $FILE
	echo -en "CC = cc\n\n" >> $FILE
	echo -en "FSAN = -fsanitize=address\n\n" >> $FILE
	echo -en "CFLAGS = -Wall -Wextra -Werror -pedantic -std=c++98 -g\n\n" >> $FILE
	echo -en "SRC =\n\n" >> $FILE
	echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
	echo -en "OBJ_SRC = \$(SRC:%.cpp=\$(OBJ_FOLDER)/%.o)\n\n" >> $FILE

	printf "GREEN = \\\033[0;32m\n" >> $FILE
	printf "RESET = \\\033[0m\n\n" >> $FILE

	echo -en "all : \$(NAME)\n\n" >> $FILE

	echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
	echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) -o \$(NAME)\n" >> $FILE
	echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "\$(OBJ_FOLDER)/%.o : %.cpp | \$(OBJ_FOLDER)" >> $FILE
	echo -en "\t\$(CC) \$(CFLAGS) -c \$< -o \$@\n\n" >> $FILE

	echo -en "\$(OBJ_FOLDER):\n" >> $FILE
	echo -en "\t@mkdir -p \$(OBJ_FOLDER)\n\n" >> $FILE

	echo -en "clean :\n" >> $FILE
	echo -en "\trm -rf \$(OBJ_FOLDER)\n\n" >> $FILE

	echo -en "fclean : clean\n" >> $FILE
	echo -en "\trm -f \$(NAME)\n" >> $FILE
	echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "sanitize: fclean \$(OBJ_SRC)\n" >> $FILE
	echo -en "\t\$(CC) \$(CFLAGS) \$(FSAN) \$(OBJ_SRC) -o \$(NAME)\n" >> $FILE
	echo -en "\t@echo \"\${GREEN}-----COMPILED FSAN DONE-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "re : fclean all\n\n" >> $FILE

	echo -en ".PHONY: all clean fclean re\n" >> $FILE
}

function ft_c_makefile()
{
	echo -en "" >> $FILE
	echo -en "NAME = $project_input\n\n" >> $FILE
	echo -en "CC = $compiler_input\n\n" >> $FILE
	echo -en "CFLAGS = -Wall -Wextra -Werror -g3\n\n" >> $FILE
	if [[ "$bonus_input" =~ ^[yY]$ ]]; then
		echo -en "BONUS_DIR =\n\n" >> $FILE
		echo -en "BONUS_SRC =\$(shell find \$(BONUS_DIR) -type f -name '*.c')\n\n" >> $FILE
	fi
	echo -en "FILE_DIR = \n\n" >> $FILE
	echo -en "SRC = \$(shell find \$(FILE_DIR) -type f -name '*.c')\n\n" >> $FILE
	echo -en "INC = -I include\n\n" >> $FILE
	echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
	if [[ "$bonus_input" =~ ^[yY]$ ]]; then
		echo -en "OBJ_BONUS = \$(patsubst %.c, \$(OBJ_FOLDER)/%.o, \$(BONUS_SRC))\n\n" >> $FILE
	fi
	echo -en "OBJ_SRC = \$(patsubst %.c, \$(OBJ_FOLDER)/%.o, \$(SRC))\n\n" >> $FILE
	echo -en "LIBFT_DIR = libft/libft.a\n\n" >> $FILE
	printf "GREEN = \\\033[0;32m\n" >> $FILE
	printf "RESET = \\\033[0m\n\n" >> $FILE

	if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
		echo -en "ifeq (\$(shell uname -s), Linux)\n" >> $FILE
		echo -en "\tMINILIBX_DIR = minilibx-linux\n" >> $FILE
		echo -en "\tMINILIBX_FLAGS = -L\$(MINILIBX) -lmlx -L/usr/lib -Imlx_linux -lXext -lX11 -lm -lz\n" >> $FILE
		echo -en "else\n" >> $FILE
		echo -en "\tMINILIBX_DIR = minilibx\n" >> $FILE
		echo -en "\tMINILIBX_FLAGS = -L\$(MINILIBX) -lmlx -framework OpenGL -framework AppKit\n" >> $FILE
		echo -en "endif\n\n" >> $FILE
	fi

	echo -en "all : \$(NAME)\n\n" >> $FILE

	echo -en "fsan : fclean \$(OBJ_SRC)\n" >> $FILE
	if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
		echo -en "\tmake -C \$(MINILIBX_DIR)\n" >> $FILE
		echo -en "\tmake -C libft\n" >> $FILE
		echo -en "\t\$(CC) \$(CFLAGS) \$(FSANITIZE) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) \$(MINILIBX_FLAGS) -o \$(NAME)\n" >> $FILE
	else
		echo -en "\tmake -C libft\n" >> $FILE
		echo -en "\t\$(CC) \$(CFLAGS) \$(FSANITIZE) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) -o \$(NAME)\n" >> $FILE
	fi
	echo -en "\t@echo \"\${GREEN}-----COMPILED FSAN DONE-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
	if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
		echo -en "\tmake -C \$(MINILIBX_DIR)\n" >> $FILE
		echo -en "\tmake -C libft\n" >> $FILE
		echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) \$(MINILIBX_FLAGS) -o \$(NAME)\n" >> $FILE
	else
		echo -en "\tmake -C libft\n" >> $FILE
		echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) -o \$(NAME)\n" >> $FILE
	fi
	echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "\$(OBJ_FOLDER)/%.o : %.c\n" >> $FILE
	echo -en "\t@mkdir -p \$(dir \$@)\n" >> $FILE
	echo -en "\t\$(CC) \$(CFLAGS) \$(INC) -c \$< -o \$@\n\n" >> $FILE

	echo -en "clean:\n" >> $FILE
	echo -en "\trm -rf \$(OBJ_FOLDER)\n" >> $FILE
	if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
		echo -en "\tmake clean -C \$(MINILIBX_DIR)\n" >> $FILE
		echo -en "\tmake clean -C libft\n\n" >> $FILE
	else
		echo -en "\tmake clean -C libft\n\n" >> $FILE
	fi

	echo -en "fclean: clean\n" >> $FILE
	if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
		echo -en "\tmake fclean -C \$(MINILIBX_DIR)\n" >> $FILE
		echo -en "\tmake fclean -C libft\n" >> $FILE
	else
		echo -en "\tmake fclean -C libft\n" >> $FILE
	fi
	echo -en "\trm -f \$(NAME)\n" >> $FILE
	echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

	echo -en "re : fclean all\n\n" >> $FILE

	if [[ "$bonus_input" =~ ^[yY]$ ]]; then
		echo -en "bonus : \$(OBJ_BONUS)\n" >> $FILE
		if [[ "$minilibx_input" =~ ^[yY]$ ]]; then
			echo -en "\tmake -C \$(MINILIBX_DIR)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_BONUS) \$(INC) \$(LIBFT_DIR) \$(MINILIBX_FLAGS) -o \$(NAME)\n" >> $FILE
		else
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_BONUS) \$(INC) \$(LIBFT_DIR) -o \$(NAME)\n" >> $FILE
		fi
		echo -en "\t@echo \"\${GREEN}-----COMPILED BONUS DONE-----\\\n\${RESET}\"\n\n" >> $FILE
	fi

	if [[ "$bonus_input" =~ ^[yY]$ ]]; then
		echo -en ".PHONY: all clean fclean re bonus fsan\n" >> $FILE
	else
		echo -en ".PHONY: all clean fclean re fsan\n" >> $FILE
	fi
}

function note()
{
	echo -en $GREEN
	echo -en " __  __ _____    ____ _____ _   _ _____ ____     _  _____ ___  ____  \n"
	echo -en "|  \/  |  ___|  / ___| ____| \ | | ____|  _ \   / \|_   _/ _ \|  _ \ \n"
	echo -en "| |\/| | |_    | |  _|  _| |  \| |  _| | |_) | / _ \ | || | | | |_) |\n"
	echo -en "| |  | |  _|   | |_| | |___| |\  | |___|  _ < / ___ \| || |_| |  _ < \n"
	echo -en "|_|  |_|_|      \____|_____|_| \_|_____|_| \_/_/   \_|_| \___/|_| \_\ \n\n"
	echo -en "+---------------------------------------------------------------------------------------------------------+\n"
	echo -en "|NOTE:                                                                                                    |\n"
	echo -en "|=====                                                                                                    |\n"
	echo -en "|1. FILE_DIR / BONUS_DIR => folder where your source files are located. so don't put files just put folder|\n"
	echo -en "|   example: FILE_DIR = src parsing execution (each of them is a folder)                                  |\n"
	echo -en "|2. if bonus is combine with mandatory is recomended to choose "n" for bonus                                |\n"
	echo -en "|3. you libft must had the combination of ft_printf and gnl and bonus                                     |\n"
	echo -en "|4. all directory must be same directory as your Makefile                                                 |\n"
	echo -en "+---------------------------------------------------------------------------------------------------------+\n"
	echo -en $RESET
}

note

# Prompt blank makefile
echo -en "which Makefile you want to create for?\n 1. CPP makefile\n 2. C makefile\n \rChoose [1/2]: "
read blank_input
while [[ ! "$blank_input" =~ ^[12]$ ]]; do
	echo -en $RED"Invalid input. Please answer 1 or 2.\n"$RESET
	echo -en "which Makefile you want to create for?\n 1. CPP makefile\n 2. C makefile\n \rChoose [1/2]: "
	read blank_input
done

# Prompt for the project name
clear
echo -en "Project name: "
read project_input

# Prompt for the compiler
if [[ "$blank_input" == "2" ]]; then
	echo -en "Compiler: "
	read compiler_input

	# prompt for bonus input
	echo -en "Do you need bonus section?\n \rChoose (y/n): "
	read bonus_input
	while [[ ! "$bonus_input" =~ ^[yYnN]$ ]]; do
		echo -en $RED"Invalid input. Please answer y or n.\n"$RESET
		echo -en "Do you need bonus section?\n \rChoose (y/n): "
		read bonus_input
	done

	# Prompt for minilibx input
	echo -en "Do you need minilibx directory?\n \rChoose (y/n): "
	read minilibx_input
	while [[ ! "$minilibx_input" =~ ^[yYnN]$ ]]; do
		echo -en $RED"Invalid input. Please answer y or n.\n"$RESET
		echo -en "Do you need minilibx directory?\n \rChoose (y/n)"
		read minilibx_input
	done

fi

# Prompt for the directory and validate it
while true; do
	echo -en "\rEnter the directory for Makefile? (if leave blank you will get current directory)\n \rEnter your directory: "
	read path_input
	# If no input is provided, default to the current directory
	if [ -z "$path_input" ]; then
		path_input="./"
		break
	fi
	# Check if the directory exists
	if [ -d "$path_input" ]; then
		break
	else
		echo -en $RED"Error: Directory '$path_input' does not exist. Please enter a valid directory.\n"$RESET
	fi
done

# animation progress bar
echo -en "Loading..."
for i in {1..50}; do
    # Calculate the percentage
    percent=$((i * 2))
    # Print the progress bar
    echo -en "\r["
    for j in $(seq 1 $i); do
        echo -n "█"
    done
    for j in $(seq $((i + 1)) 50); do
        echo -n "▒"
    done
    echo -n "] $percent%"
    sleep 0.1
done
echo -en "\n\n"

# Create the Makefile
touch $FILE
if [[ "$blank_input" == "1" ]]; then
	ft_cpp_makefile
else
	ft_c_makefile
fi

# Optional: Move the Makefile if a custom directory is
 if [[ "$blank_input" == "1" ]]; then
	if [ -n "$path_input" ] && [ "$path_input" != "./" ]; then
		mv ./Makefile "$path_input/Makefile"
		echo -en $GREEN"\r                         Makefile created\n"$RESET
	else
		echo -en $GREEN"\r                         Makefile created\n"$RESET
	fi
else
	if [ -n "$path_input" ] && [ "$path_input" != "./" ]; then
		# If a custom path is provided
		mkdir -p "$path_input/src"
		mkdir -p "$path_input/include"
		if [[ "$bonus_input" =~ ^[yY]$ ]]; then
			mkdir -p "$path_input/bonus"
		fi
		mv ./Makefile "$path_input/Makefile"
		echo -en $GREEN"\r                         Makefile created\n"$RESET
	else
		# If no path is provided, create directories in the current directory
		mkdir -p ./src
		mkdir -p ./include
		if [[ "$bonus_input" =~ ^[yY]$ ]]; then
			mkdir -p ./bonus
		fi
		echo -en $GREEN"\r                         Makefile created\n"$RESET
	fi
fi
