/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fun.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 19:18:10 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 05:20:43 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

unsigned int			min(unsigned int x, unsigned int y)
{
	if (x <= y)
		return (x);
	else
		return (y);
}

unsigned short int		temp_solution(char *str)
{
	unsigned short int i;

	i = 0;
	while (str[i] != '\n')
	{
		i++;
	}
	return (i + 1);
}

char					*ft_cut(char *src)
{
	char			*dest;
	unsigned long	i;

	i = 0;
	while (src[i])
	{
		i++;
	}
	dest = (char *)malloc(i + 1);
	if (dest == NULL)
		return (src);
	i = 0;
	while (src[i])
	{
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	free(src);
	return (dest);
}
