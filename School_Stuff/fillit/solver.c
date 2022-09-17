/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   solver.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/16 11:49:13 by eleanna           #+#    #+#             */
/*   Updated: 2019/11/25 00:03:31 by acarole          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"

short	back_track(t_map *map, t_list *lst)
{
	short	i;
	short	j;
	t_tet	*tetri;

	if (lst == NULL)
		return (1);
	j = 0;
	tetri = (t_tet*)(lst->content);
	while (j < map->border - tetri->height + 1)
	{
		i = 0;
		while (i < map->border - tetri->width + 1)
		{
			if (place_tetri(map, tetri, i, j))
			{
				if (back_track(map, lst->next))
					return (1);
				else
					setchar_tetri(map, tetri, create_point(i, j), '.');
			}
			i++;
		}
		j++;
	}
	return (0);
}

t_map	*solve(t_list *lst)
{
	t_map	*map;
	short	size;

	size = 2;
	while (size * size < list_count(lst) * 4)
		size++;
	map = create_map(size);
	while (!back_track(map, lst))
	{
		size++;
		free_map(map);
		map = create_map(size);
	}
	return (map);
}
