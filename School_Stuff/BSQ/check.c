/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   check.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/24 14:46:21 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 03:59:26 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

unsigned int		atoi_changed(char *str, int i_s)
{
	int i;
	int sum;

	i = 0;
	sum = 0;
	while (str[i] != 0 && str[i] >= '0' && str[i] <= '9' && i != i_s)
	{
		sum = (sum * 10) + str[i] - '0';
		i++;
	}
	if (i < i_s)
		return (0);
	else
		return (sum);
}

unsigned short int	height_check(char *str, int i_s)
{
	unsigned int height;

	height = atoi_changed(str, i_s);
	if (!height)
		return (0);
	else
	{
		return (height == g_y);
	}
}

unsigned short int	width_symb_check(char *str, int i_s)
{
	unsigned int	i;
	unsigned int	width;

	g_flag = 0;
	i = i_s + 4;
	while (i <= g_x * g_y + i_s + 4)
	{
		width = 0;
		while (str[i] != '\n')
		{
			if (str[i] != g_obst && str[i] != g_empt)
				return (0);
			if (str[i] == g_obst)
				g_flag = 1;
			width++;
			i++;
		}
		i++;
		if (width != g_x)
			return (0);
	}
	return (1);
}

unsigned short int	check(char *str, int i_s)
{
	if (str == 0)
		return (0);
	if (!height_check(str, i_s))
		return (0);
	else if (!width_symb_check(str, i_s))
		return (0);
	else
		return (1);
}
