/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   draw.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 23:04:05 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/24 13:43:40 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

void	draw(char *str, int coord, unsigned short int a)
{
	int i;
	int j;

	i = 0;
	while (i < a)
	{
		j = 0;
		while (j < a)
		{
			str[coord + j] = g_full;
			j++;
		}
		coord = coord + g_x + 1;
		i++;
	}
}
