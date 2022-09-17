/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_realloc.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 18:10:15 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 03:09:07 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "bsq.h"

void	ft_strcpy(char *dest, char *src, unsigned long size)
{
	unsigned long	i;

	i = 0;
	while (i < size)
	{
		dest[i] = src[i];
		i++;
	}
}

char	*ft_realloc(char *str, unsigned long size)
{
	char *new_str;

	new_str = (char *)malloc(sizeof(char) * size);
	if (new_str == NULL)
		return (0);
	ft_strcpy(new_str, str, size / 2);
	free(str);
	return (new_str);
}
