# Name :: execution name
NAME = 

# CC :: the compiler that you want to use
CC = 

# CFLAGS :: the flags that you want to compile
CFLAGS = 

# SRC :: the files that you want to compile
SRC = 

# BONUS :: the bonus files that you want to compile
BONUS = 

# object_files :: the folder that put all the ".o" files
OBJ_FOLDER = object_files

# addprefix :: add the folder path to the object files to put to the folder
OBJ_SRC = $(addprefix $(OBJ_FOLDER)/, $(SRC:.c=.o))

OBJ_BONUS = $(addprefix $(OBJ_FOLDER)/, $(BONUS:.c=.o))

# all :: compile the executable file
all : $(NAME)

# "$@" is the target means $(NAME)
$(NAME) : $(OBJ_SRC)
	$(CC) $(CFLAGS) $(OBJ_SRC) -o $@

# "/" is a separator, so the target is "object_files/*.o" and the prerequisite is "*.c
# "|"  means that the target will be created before the "%.o : %.c"
# "%.o : %.c" means make ".o" file from ".c" file
$(OBJ_FOLDER)/%.o : %.c | $(OBJ_FOLDER)
	$(CC) $(CFLAGS) -c $< -o $@

# create the folder
$(OBJ_FOLDER):
	@mkdir -p $(OBJ_FOLDER)

# clean the object folder that contain object files
clean :
	rm -rf $(OBJ_FOLDER)

# clean the object folder and the executable file
fclean : clean
	rm -f $(NAME)

# clean the object folder and the executable file, then recompile the executable file
re : fclean all

# make bonus part
bonus : $(OBJ_BONUS)
	$(CC) $(CFLAGS) $(OBJ_BONUS) -o $(NAME)

# .PHONY :: mean that the target is not a file
.PHONY: all clean fclean re bonus
