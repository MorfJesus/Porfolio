/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   solver.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 19:22:14 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 18:33:25 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

unsigned short int		square_check(unsigned short a, char *str,
		unsigned int coord, unsigned int *coord2)
{
	unsigned short int j;
	unsigned short int i;

	i = 0;
	while (i < a)
	{
		j = 0;
		while (j < a)
		{
			if ((str[coord + j] == g_obst) || (coord + j >= (g_x + 1) * g_y))
			{
				return (j + 1);
			}
			j++;
		}
		coord = coord + g_x + 1;
		i++;
	}
	if (a > g_a_new)
	{
		g_a_new = a;
		*coord2 = coord - a * (g_x + 1);
	}
	return (0);
}

unsigned short int		square_move(char *str, unsigned short *a,
		unsigned int *coord2, unsigned int coord)
{
	unsigned short int	i;
	unsigned short int	j;
	unsigned short int	memory;

	i = 0;
	while (i++ <= (g_y - *a))
	{
		j = 0;
		while (j <= g_x - *a)
		{
			memory = square_check(*a, str, coord + j, coord2);
			if (!memory)
			{
				if (*a == min(g_x, g_y))
					return (1);
				(*a)++;
				if (j <= g_x - (*a) && i < g_y - (*a))
					square_check(*a, str, coord + j, coord2);
			}
			j += memory;
		}
		coord = coord + g_x + 1;
	}
	*a = g_a_new;
	return (1);
}

unsigned short int		iteration(char *str)
{
	unsigned short	a;
	unsigned int	coord2;
	unsigned int	coord;

	a = 0;
	g_a_new = 0;
	coord2 = 0;
	coord = 0;
	if (square_move(str, &a, &coord2, coord))
	{
		draw(str, coord2, a);
		return (a);
	}
	return (0);
}
