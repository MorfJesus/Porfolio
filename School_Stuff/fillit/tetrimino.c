/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tetrimino.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 18:24:54 by acarole           #+#    #+#             */
/*   Updated: 2019/11/25 00:03:02 by acarole          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"

t_tet		*create_tetri(char **tetrim, short height, short width, char letter)
{
	t_tet *tetris;

	if ((tetris = ft_memalloc(sizeof(t_tet))) == NULL)
		return (NULL);
	tetris->tetrim = tetrim;
	tetris->letter = letter;
	tetris->height = height;
	tetris->width = width;
	return (tetris);
}

t_point		*create_point(short x, short y)
{
	t_point *point;

	if ((point = ft_memalloc(sizeof(t_point))) == NULL)
		return (NULL);
	point->x = x;
	point->y = y;
	return (point);
}

void		get_min_and_max(char *tetri, t_point *min, t_point *max)
{
	short	i;

	i = 0;
	while (i < 19)
	{
		if (tetri[i] == '#')
		{
			if (min->x > i % 5)
				min->x = i % 5;
			if (min->y > i / 5)
				min->y = i / 5;
			if (max->x < i % 5)
				max->x = i % 5;
			if (max->y < i / 5)
				max->y = i / 5;
		}
		i++;
	}
}

t_tet		*get_block(char *tetri, char c)
{
	t_point	*min;
	t_point	*max;
	char	**tetrim;
	short	i;
	t_tet	*tetri_content;

	i = 0;
	min = create_point(3, 3);
	max = create_point(0, 0);
	get_min_and_max(tetri, min, max);
	tetrim = ft_memalloc(sizeof(char*) * (max->y - min->y) + 1);
	while (i < max->y - min->y + 1)
	{
		tetrim[i] = ft_strnew((max->x - min->x) + 1);
		ft_memcpy(tetrim[i], &tetri[min->x + (i + min->y) * 5],
					(max->x - min->x) + 1);
		i++;
	}
	tetri_content = create_tetri(tetrim, (max->y - min->y) + 1,
									(max->x - min->x + 1), c);
	ft_memdel((void**)&min);
	ft_memdel((void**)&max);
	return (tetri_content);
}

t_list		*free_all_tetri(t_list *lst_tet)
{
	t_tet		*tetri;
	t_list		*next;
	short		i;

	i = 0;
	while (lst_tet)
	{
		tetri = (t_tet*)lst_tet->content;
		next = lst_tet->next;
		while (i < tetri->height)
		{
			ft_memdel((void**)(&(tetri->tetrim[i])));
			i++;
		}
		ft_memdel((void**)&lst_tet);
		lst_tet = next;
	}
	return (NULL);
}
