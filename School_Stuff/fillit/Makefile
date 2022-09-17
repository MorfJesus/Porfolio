# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: acarole <acarole@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/06 20:22:27 by eleanna           #+#    #+#              #
#    Updated: 2019/12/07 16:12:33 by eleanna          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = fillit
FLAGS = -Wall -Wextra -Werror
SRC =	main.c \
		get_data.c \
		list.c \
		checker.c \
		solver.c \
		tetrimino.c \
		map.c \
		libft/ft_memalloc.c \
		libft/ft_memcpy.c \
		libft/ft_putstr.c \
		libft/ft_memdel.c	\
		libft/ft_strjoin.c \
		libft/ft_strnew.c \
		libft/get_next_line.c \
		libft/ft_bzero.c \
		libft/ft_putchar.c \
		libft/ft_strchr.c \
		libft/ft_strdup.c \
		libft/ft_strlen.c \
		libft/ft_strsub.c \
		libft/ft_strjoin2.c \
		libft/ft_strcat.c

SRCO = $(SRC:.c=.o)

all: $(NAME)

$(NAME): $(SRCO)
	@gcc  -I . -g -Wall -Wextra -Werror -o $(NAME) $(FLAGS) $(SRCO)

%.o: %.c
	@gcc -I . -Wall -Wextra -Werror -o $@ -c $<


clean:
	@/bin/rm -f *.o
	@/bin/rm -f libft/*.o
	
fclean: clean
	@/bin/rm -f $(NAME)
	@/bin/rm -f libft/libft.a
re: fclean all

.PHONY: all clean fclean re
