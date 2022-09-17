/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/09/14 15:47:24 by acarole           #+#    #+#             */
/*   Updated: 2019/12/07 15:55:36 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>

char	*ft_strdup(const char *s)
{
	char	*dupl;
	size_t	num;

	num = 0;
	dupl = (char *)malloc((ft_strlen(s) + 1));
	if (dupl)
	{
		while (s[num])
		{
			dupl[num] = s[num];
			num++;
		}
		dupl[num] = 0;
	}
	return (dupl);
}
