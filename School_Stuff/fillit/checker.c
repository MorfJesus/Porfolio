/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   checker.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/10 18:59:47 by acarole           #+#    #+#             */
/*   Updated: 2019/12/07 17:08:20 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"
#include <stdio.h>

void		initialization(short *i, short *numb_of_blocks, short *buf)
{
	*i = 0;
	*numb_of_blocks = 0;
	*buf = 0;
}

short		ft_check_square(char *ptr)
{
	short i;
	short j;
	short numb_of_blocks;

	initialization(&i, &numb_of_blocks, &j);
	while (ptr[i] && numb_of_blocks < 26)
	{
		j = 0;
		while (ptr[i++] && ptr[i] != '\n')
		{
			j++;
			i++;
		}
		if (j != 4)
			return (1);
		i++;
		if ((i - numb_of_blocks) % 20 == 0)
		{
			numb_of_blocks++;
			i++;
		}
	}
	return (((i - numb_of_blocks) % 20 || (j % 4) || (numb_of_blocks > 26)
	|| (ptr[0] == 0) || (i != 0 && ptr[i] == '\0' && ptr[i - 1] == '\n' && ptr[i - 3] == '\n')));
}

short		top_botom(char *ptr, short i, short numb_of_blocks)
{
	short count_connection;

	count_connection = 0;
	if ((i < (15 + 21 * numb_of_blocks)) && ptr[i] == '#')
		if (ptr[i + 5] == '#')
			count_connection++;
	if ((i < (18 + 21 * numb_of_blocks)) && ptr[i] == '#')
		if (ptr[i + 1] == '#')
			count_connection++;
	if ((i > (4 + 21 * numb_of_blocks)) && ptr[i] == '#')
		if (ptr[i - 5] == '#')
			count_connection++;
	if ((i > (21 * numb_of_blocks)) && ptr[i] == '#')
		if (ptr[i - 1] == '#')
			count_connection++;
	return (count_connection);
}

short		connections_count(char *ptr)
{
	short count_connection;
	short i;
	short count_gratings;
	short numb_of_blocks;

	count_connection = 0;
	initialization(&i, &numb_of_blocks, &count_gratings);
	while (ptr[i])
	{
		if (!(ptr[i] == '\n' || ptr[i] == '#' || ptr[i] == '.'))
			return (1);
		if (ptr[i] == '#')
			count_gratings++;
		count_connection += top_botom(ptr, i, numb_of_blocks);
		if (((++i) - numb_of_blocks) % 20 == 0)
		{
			numb_of_blocks++;
			if (count_gratings != 4 || count_connection < 6)
				return (1);
			count_gratings = 0;
			count_connection = 0;
			i++;
		}
	}
	return (0);
}

short		check_all(char *str)
{
	printf("%d\n%d\n", !ft_check_square(str), !connections_count(str));
	return (!ft_check_square(str) && !connections_count(str));
}
