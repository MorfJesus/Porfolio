/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   set_symb.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 18:54:13 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 03:58:59 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

unsigned short int	set_symb(char *str)
{
	unsigned short int i;

	if (str == 0)
		return (0);
	i = 0;
	while (str[i] != '\n')
	{
		i++;
		if (!str[i])
			return (0);
	}
	if (i >= 3)
	{
		g_full = str[i - 1];
		g_obst = str[i - 2];
		g_empt = str[i - 3];
		if (g_empt == g_obst)
			return (0);
		return (i - 3);
	}
	else
		return (0);
}

void				measure(char *str)
{
	unsigned int i;

	i = 0;
	g_x = 0;
	g_y = 0;
	if (str == 0)
		return ;
	while (str[i] != '\n' && str[i])
		i++;
	if (str[i])
		i++;
	while (str[i] != '\n' && str[i])
	{
		g_x++;
		i++;
	}
	while (str[i])
	{
		if (str[i] == '\n')
			g_y++;
		i++;
	}
}
