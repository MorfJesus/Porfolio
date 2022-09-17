# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eleanna <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/07/15 14:14:27 by eleanna           #+#    #+#              #
#    Updated: 2019/07/25 18:17:30 by eleanna          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = bsq

SRC = *.c

HDR = .

all: $(NAME)

$(NAME):
	gcc -o $(NAME) *.c

clean:
	/bin/rm -f main.o

fclean: clean
	/bin/rm -f $(NAME)
re: fclean all
