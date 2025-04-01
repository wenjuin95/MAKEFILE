#!/bin/bash

FILE="Makefile"
bonus_input=""
project_input=""
compiler_input=""
path_input=""

function ft_input_the_rest()
{
	if [[ "$bonus_input" =~ ^[yY]$ ]]; then
		if [[ "$minilibx_input" =~ ^[yYnN]$ ]]; then # if minilibx is needed
			echo -en "CFLAGS = -Wall -Wextra -Werror -g\n\n" >> $FILE
			echo -en "INC = -I include\n\n" >> $FILE
			echo -en "SRC_DIR = src\n\n" >> $FILE
			echo -en "BONUS_DIR = bonus\n\n" >> $FILE
			echo -en "SRC = \$(wildcard \$(SRC_DIR)/*.c)\n\n" >> $FILE
			echo -en "BONUS = \$(wildcard \$(BONUS_DIR)/*.c)\n\n" >> $FILE
			echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
			echo -en "OBJ_SRC = \$(SRC:%.c=\$(OBJ_FOLDER)/%.o)\n\n" >> $FILE
			echo -en "OBJ_BONUS = \$(BONUS:%.c=\$(OBJ_FOLDER)/%.o)\n\n" >> $FILE
			echo -en "LIBFT_DIR = libft/libft.a\n\n" >> $FILE

			echo -en "# check for OS\n" >> $FILE
			echo -en "ifeq (\$(shell uname), Linux)\n" >> $FILE
			echo -en "\tMLX_DIR = minilibx-linux\n" >> $FILE
			echo -en "\tMINILIBX_LIBRARY = -L\$(MINILIBX) -lmlx -L/usr/lib -Imlx_linux -lXext -lX11 -lm -lz\n" >> $FILE
			echo -en "else\n" >> $FILE
			echo -en "\tMLX_DIR = minilibx\n" >> $FILE
			echo -en "\tMINILIBX_LIBRARY = -L\$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit\n" >> $FILE
			echo -en "endif\n\n" >> $FILE

			printf "GREEN = \\\033[0;32m\n" >> $FILE
			printf "RESET = \\\033[0m\n\n" >> $FILE

			echo -en "all : \$(NAME)\n\n" >> $FILE

			echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\tmake -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(LIBFT_DIR) \$(MLX_DIR) -o \$(NAME)\n\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER)/%.o : %.c | \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) -c \$< -o \$@\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER):\n" >> $FILE
			echo -en "\t@mkdir -p \$(OBJ_FOLDER)\n\n" >> $FILE

			echo -en "clean :\n" >> $FILE
			echo -en "make clean -C libft\n" >> $FILE
			echo -en "\tmake clean -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\trm -rf \$(OBJ_FOLDER)\n\n" >> $FILE

			echo -en "fclean : clean\n" >> $FILE
			echo -en "\tmake fclean -C libft\n" >> $FILE
			echo -en "\tmake fclean -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\trm -f \$(NAME)\n\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "re : fclean all\n\n" >> $FILE

			echo -en "bonus : \$(OBJ_BONUS)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_BONUS) \$(LIBFT_DIR) \$(MLX_DIR) -o \$(NAME)\n\n" >> $FILE

			echo -en ".PHONY: all clean fclean re bonus\n" >> $FILE
		else
			echo -en "CFLAGS = -Wall -Wextra -Werror\n\n" >> $FILE
			echo -en "INC = -I include\n\n" >> $FILE
			echo -en "SRC_DIR = src\n\n" >> $FILE
			echo -en "BONUS_DIR = bonus\n\n" >> $FILE
			echo -en "SRC = \$(wildcard \$(SRC_DIR)/*.c)\n\n" >> $FILE
			echo -en "BONUS = \$(wildcard \$(BONUS_DIR)/*.c)\n\n" >> $FILE
			echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
			echo -en "OBJ_SRC = \$(addprefix \$(OBJ_FOLDER)/, \$(SRC:.c=.o))\n\n" >> $FILE
			echo -en "OBJ_BONUS = \$(addprefix \$(OBJ_FOLDER)/, \$(BONUS:.c=.o))\n\n" >> $FILE
			echo -en "LIBFT_DIR = libft/libft.a\n\n" >> $FILE

			printf "GREEN = \\\033[0;32m\n" >> $FILE
			printf "RESET = \\\033[0m\n\n" >> $FILE

			echo -en "all : \$(NAME)\n\n" >> $FILE

			echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\tmake -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(LIBFT_DIR)  -o \$(NAME)\n\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER)/%.o : %.c | \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) -c \$< -o \$@\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER):\n" >> $FILE
			echo -en "\t@mkdir -p \$(OBJ_FOLDER)\n\n" >> $FILE

			echo -en "clean :\n" >> $FILE
			echo -en "make clean -C libft\n" >> $FILE
			echo -en "\trm -rf \$(OBJ_FOLDER)\n\n" >> $FILE

			echo -en "fclean : clean\n" >> $FILE
			echo -en "\tmake fclean -C libft\n" >> $FILE
			echo -en "\trm -f \$(NAME)\n\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "re : fclean all\n\n" >> $FILE

			echo -en "bonus : \$(OBJ_BONUS)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_BONUS) \$(LIBFT_DIR)  -o \$(NAME)\n\n" >> $FILE

			echo -en ".PHONY: all clean fclean re bonus\n" >> $FILE
		fi
	else
		if [[ "$minilibx_input" =~ ^[yYnN]$ ]]; then # if minilibx is needed
			echo -en "FSANITIZE = -fsanitize=address\n\n" >> $FILE
			echo -en "CFLAGS = -Wall -Wextra -Werror -g3\n\n" >> $FILE
			echo -en "INC = -I include\n\n" >> $FILE
			echo -en "FILE_DIR = src\n\n" >> $FILE
			echo -en "SRC = \$(shell find \$(FILE_DIR) -type f -name '*.c')\n\n" >> $FILE
			echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
			echo -en "OBJ_SRC = \$(patsubst %.c, \$(OBJ_FOLDER)/%.o, \$(SRC))\n\n" >> $FILE
			echo -en "LIBFT_DIR = libft/libft.a\n\n" >> $FILE

			echo -en "# check for OS\n" >> $FILE
			echo -en "ifeq (\$(shell uname), Linux)\n" >> $FILE
			echo -en "\tMLX_DIR = minilibx-linux\n" >> $FILE
			echo -en "\tMINILIBX_LIBRARY = -L\$(MINILIBX) -lmlx -L/usr/lib -Imlx_linux -lXext -lX11 -lm -lz\n" >> $FILE
			echo -en "else\n" >> $FILE
			echo -en "\tMLX_DIR = minilibx\n" >> $FILE
			echo -en "\tMINILIBX_LIBRARY = -L\$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit\n" >> $FILE
			echo -en "endif\n\n" >> $FILE

			printf "GREEN = \\\033[0;32m\n" >> $FILE
			printf "RESET = \\\033[0m\n\n" >> $FILE

			echo -en "all : \$(NAME)\n\n" >> $FILE

			echo -en "fsan: fclean \$(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(FSANITIZE) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR)-o \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED FSAN DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) -o \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER)/%.o : %.c\n" >> $FILE
			echo -en "\t@mkdir -p \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) -c \$< -o \$@\n\n" >> $FILE

			echo -en "clean :\n" >> $FILE
			echo -en "\trm -rf \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\tmake clean -C libft\n" >> $FILE
			echo -en "\tmake clean -C \$(MLX_DIR)\n" >> $FILE

			echo -en "fclean : clean\n" >> $FILE
			echo -en "\tmake fclean -C libft\n" >> $FILE
			echo -en "\tmake fclean -C \$(MLX_DIR)\n" >> $FILE
			echo -en "\trm -f \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "re : fclean all\n\n" >> $FILE

			echo -en ".PHONY: all clean fclean re\n" >> $FILE
		else
			echo -en "FSANITIZE = -fsanitize=address\n\n" >> $FILE
			echo -en "CFLAGS = -Wall -Wextra -Werror -g3\n\n" >> $FILE
			echo -en "INC = -I include\n\n" >> $FILE
			echo -en "FILE_DIR = src\n\n" >> $FILE
			echo -en "SRC = \$(shell find \$(FILE_DIR) -type f -name '*.c')\n\n" >> $FILE
			echo -en "OBJ_FOLDER = object_files\n\n" >> $FILE
			echo -en "OBJ_SRC = \$(patsubst %.c, \$(OBJ_FOLDER)/%.o, \$(SRC))\n\n" >> $FILE
			echo -en "LIBFT_DIR = libft/libft.a\n\n" >> $FILE

			printf "GREEN = \\\033[0;32m\n" >> $FILE
			printf "RESET = \\\033[0m\n\n" >> $FILE

			echo -en "all : \$(NAME)\n\n" >> $FILE

			echo -en "fsan: fclean $(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(FSANITIZE) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR)-o \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED FSAN DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(NAME) : \$(OBJ_SRC)\n" >> $FILE
			echo -en "\tmake -C libft\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) \$(OBJ_SRC) \$(INC) \$(LIBFT_DIR) -o \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----COMPILED DONE-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "\$(OBJ_FOLDER)/%.o : %.c\n" >> $FILE
			echo -en "\t@mkdir -p \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\t\$(CC) \$(CFLAGS) -c \$< -o \$@\n\n" >> $FILE

			echo -en "clean :\n" >> $FILE
			echo -en "\trm -rf \$(OBJ_FOLDER)\n" >> $FILE
			echo -en "\tmake clean -C libft\n\n" >> $FILE

			echo -en "fclean : clean\n" >> $FILE
			echo -en "\tmake fclean -C libft\n" >> $FILE
			echo -en "\trm -f \$(NAME)\n" >> $FILE
			echo -en "\t@echo \"\${GREEN}-----REMOVED ALL FILES-----\\\n\${RESET}\"\n\n" >> $FILE

			echo -en "re : fclean all\n\n" >> $FILE

			echo -en ".PHONY: all clean fclean re\n" >> $FILE
		fi
	fi
}

echo -en " __  __ _____    ____ _____ _   _ _____ ____     _  _____ ___  ____  \n"
echo -en "|  \/  |  ___|  / ___| ____| \ | | ____|  _ \   / \|_   _/ _ \|  _ \ \n"
echo -en "| |\/| | |_    | |  _|  _| |  \| |  _| | |_) | / _ \ | || | | | |_) |\n"
echo -en "| |  | |  _|   | |_| | |___| |\  | |___|  _ < / ___ \| || |_| |  _ < \n"
echo -en "|_|  |_|_|      \____|_____|_| \_|_____|_| \_/_/   \_|_| \___/|_| \_\ \n\n"


#questions
echo -en "Project name: "
read project_input
echo -en "Compiler: "
read compiler_input

# Prompt for bonus input outside of ft_input_the_rest
read -p "Do you need bonus section? (y/n): " bonus_input
while [[ ! "$bonus_input" =~ ^[yYnN]$ ]]; do
    echo "Invalid input. Please answer y or n."
    read -p "Do you need bonus section? (y/n): " bonus_input
done

# Prompt for minilibx input
read -p "Do you need minilibx? (y/n): " minilibx_input
while [[ ! "$minilibx_input" =~ ^[yYnN]$ ]]; do
	echo "Invalid input. Please answer y or n."
	read -p "Do you need minilibx? (y/n): " minilibx_input
done

#questions
echo -en "\rEnter the directory for Makefile? (default: current directory): "
read path_input

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

touch $FILE

echo -en "NAME = $project_input\n\n" >> $FILE
echo -en "CC = $compiler_input\n\n" >> $FILE
ft_input_the_rest

# Optional: Move the Makefile if a custom directory is specified
if [ -n "$path_input" ] && [ "$path_input" != "./" ]; then
    # If a custom path is provided
    mkdir -p "$path_input/src"
    mkdir -p "$path_input/include"
    if [[ "$bonus_input" =~ ^[yY]$ ]]; then
        mkdir -p "$path_input/bonus"
    fi
    mv ./Makefile "$path_input/Makefile"
else
    # If no path is provided, create directories in the current directory
    mkdir -p ./src
    mkdir -p ./include
    if [[ "$bonus_input" =~ ^[yY]$ ]]; then
        mkdir -p ./bonus
    fi
    echo "No directory specified. Makefile and directories created in the current directory."
fi
