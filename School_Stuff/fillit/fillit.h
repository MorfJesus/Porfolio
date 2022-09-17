/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fillit.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/10 17:57:00 by acarole           #+#    #+#             */
/*   Updated: 2019/11/25 00:00:58 by acarole          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FILLIT_H
# define FILLIT_H
# include <stdlib.h>
# include <fcntl.h>
# include <unistd.h>
# include "libft/libft.h"

typedef	struct	s_map
{
	short		border;
	char		**content;
}				t_map;

typedef struct	s_tetrimino
{
	char		**tetrim;
	char		letter;
	short		height;
	short		width;
}				t_tet;

typedef struct	s_point
{
	short		x;
	short		y;
}				t_point;

t_list			*ft_list_new(void const *content, size_t size);
void			ft_list_add(t_list **alst, t_list *new_list);
void			ft_list_rev(t_list **lst);
short			list_count(t_list *lst);
short			check_all(char *str);
short			is_filevalid(char *tetris);
char			*read_file(char *argv);
t_list			*get_tet_list(char *tetris);
void			print_map(t_map *map);
t_map			*create_map(short size);
void			free_map(t_map *map);
short			place_tetri(t_map *map, t_tet *t, short x, short y);
void			setchar_tetri(t_map *map, t_tet *t, t_point *p, char c);
t_point			*create_point(short x, short y);
t_tet			*get_block(char *tetris, char c);
t_list			*free_all_tetri(t_list *lst_tet);
t_map			*solve(t_list *lst);

#endif
