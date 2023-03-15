# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: mhaan <mhaan@student.codam.nl>               +#+                      #
#                                                    +#+                       #
#    Created: 2023/03/02 15:18:58 by mhaan         #+#    #+#                  #
#    Updated: 2023/03/15 12:58:02 by mhaan         ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#GENERAL VARIABLES:
NAME := libft_ext.a
RM := /bin/rm -rf

#COMPILATION VARIABLES:
CFLAGS ?= -Wall -Wextra -Werror
AR := ar -crs

# Include files and directories:
INC_DIRS := ./ft_printf/includes ./libft ./get_next_line
INCLUDES := $(foreach D,$(INC_DIRS),-I$(D))
INC_FILES := libft/libft.h ft_printf/includes/ft_printf.h get_next_line/get_next_line.h

# Source files and directories:
LIBFT_DIR := 		./libft
LIBFT_SRC_DIR :=	$(LIBFT_DIR)
LIBFT_SRC :=		ft_atoi.c ft_bzero.c ft_calloc.c ft_isalnum.c ft_isalpha.c \
					ft_isascii.c ft_isdigit.c ft_isprint.c ft_itoa.c ft_memchr.c \
					ft_memcmp.c ft_memcpy.c ft_memmove.c ft_memset.c ft_putchar_fd.c \
					ft_putendl_fd.c ft_putnbr_fd.c ft_putstr_fd.c ft_split.c \
					ft_strchr.c ft_strdup.c ft_striteri.c ft_strjoin.c ft_strlcat.c \
					ft_strlcpy.c ft_strlen.c ft_strmapi.c ft_strncmp.c ft_strnstr.c \
					ft_strrchr.c ft_strtrim.c ft_substr.c ft_tolower.c ft_toupper.c

PRINTF_DIR :=		./ft_printf
PRINTF_SRC_DIR :=	$(PRINTF_DIR)/src
PRINTF_SRC :=		ft_printf.c helpers.c

GNL_DIR			:=	./get_next_line
GNL_SRC_DIR		:=	$(GNL_DIR)
GNL_SRC			:=	get_next_line_bonus.c get_next_line_utils_bonus.c

SRC				:=	$(addprefix $(LIBFT_SRC_DIR)/, $(LIBFT_SRC)) \
					$(addprefix $(PRINTF_SRC_DIR)/, $(PRINTF_SRC)) \
					$(addprefix $(GNL_SRC_DIR)/, $(GNL_SRC))


# Object files and directories:
OBJ_DIR			:=		./obj

# LIBFT_OBJ_DIR :=		./libft/obj
LIBFT_OBJS		:=		$(addprefix $(OBJ_DIR)/,$(notdir $(LIBFT_SRC:.c=.o)))

# PRINTF_OBJ_DIR :=	.	/ft_printf/obj
PRINTF_OBJS 	:=		$(addprefix $(OBJ_DIR)/,$(notdir $(PRINTF_SRC:.c=.o)))

# GNL_OBJ_DIR	:= 		./get_next_line/obj
GNL_OBJS		:=		$(addprefix $(OBJ_DIR)/,$(notdir $(GNL_SRC:.c=.o)))

OBJ				:=		$(LIBFT_OBJS) $(PRINTF_OBJS) $(GNL_OBJS)

# Archive files and directories:
LIBFT_AR :=			$(LIBFT_DIR)/libft.a

#RECIPES:
all:	$(NAME)

clean:
		$(RM) $(LIBFT_OBJ_DIR)
		$(RM) $(PRINTF_OBJ_DIR)
		$(RM) $(GNL_OBJ_DIR)
		$(RM) $(OBJ)

fclean: clean
		$(RM) $(NAME)
		$(RM) $(LIBFT_AR)

re:
		@$(MAKE) fclean
		@$(MAKE) all

#RULES:
# $(NAME): $(LIBFT_AR) $(PRINTF_OBJS) $(GNL_OBJS)
# $(AR) $(NAME) $(PRINTF_OBJS) $(GNL_OBJS)
$(NAME) : $(OBJ)
	$(AR) $(NAME) $(OBJ)

$(LIBFT_AR): $(NAME)
		@$(MAKE) bonus -j -C libft
		mv $(LIBFT_AR) ./$(NAME)

# $(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INC_FILES)
$(OBJ_DIR)/%.o: $(SRC) $(INC_FILES)
		@mkdir -p $(OBJ_DIR)
		gcc $(CFLAGS) $(INCLUDES) -c -o $@ $<

$(OBJ_DIR)/%.o: $(PRINTF_SRC_DIR)/%.c $(INC_FILES)
		@mkdir -p $(PRINTF_OBJ_DIR)
		gcc $(CFLAGS) $(INCLUDES) -c -o $@ $<


$(GNL_OBJ_DIR)/%.o: $(GNL_SRC_DIR)/%.c $(INC_FILES)
		@mkdir -p $(GNL_OBJ_DIR)
		gcc $(CFLAGS) $(INCLUDES) -c -o $@ $<

#OTHER:
.PHONY:
		all clean fclean re