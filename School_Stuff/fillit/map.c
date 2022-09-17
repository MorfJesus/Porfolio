/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   map.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 18:28:41 by acarole           #+#    #+#             */
/*   Updated: 2019/11/25 18:36:58 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"

void		print_map(t_map *map)
{
	short i;

	i = 0;
	while (i < map->border)
	{
		ft_putstr(map->content[i]);
		write(1, "\n", 1);
		++i;
	}
}

t_map		*create_map(short size)
{
	t_map	*map;
	short	i;
	short	j;

	i = 0;
	if ((map = (t_map*)ft_memalloc(sizeof(t_map))) == NULL)
		return (NULL);
	map->border = size;
	if ((map->content = (char**)ft_memalloc(sizeof(char *) * size)) == NULL)
		return (NULL);
	while (i < size)
	{
		if ((map->content[i] = ft_strnew(size)) == NULL)
			return (NULL);
		j = 0;
		while (j < size)
		{
			map->content[i][j] = '.';
			j++;
		}
		i++;
	}
	return (map);
}

void		free_map(t_map *map)
{
	short i;

	i = 0;
	while (i < map->border)
	{
		free(map->content[i]);
		i++;
	}
	free(map->content);
	free(map);
}

short		place_tetri(t_map *map, t_tet *tetri, short x, short y)
{
	short	i;
	short	j;

	i = 0;
	while (i < tetri->width)
	{
		j = 0;
		while (j < tetri->height)
		{
			if (tetri->tetrim[j][i] == '#' && map->content[y + j][x + i] != '.')
				return (0);
			++j;
		}
		++i;
	}
	setchar_tetri(map, tetri, create_point(x, y), tetri->letter);
	return (1);
}

void		setchar_tetri(t_map *map, t_tet *tetri, t_point *point, char c)
{
	short	i;
	short	j;

	i = 0;
	while (i < tetri->width)
	{
		j = 0;
		while (j < tetri->height)
		{
			if (tetri->tetrim[j][i] == '#')
				map->content[point->y + j][point->x + i] = c;
			j++;
		}
		i++;
	}
	if (point)
	{
		free(point);
		point = NULL;
	}
}
