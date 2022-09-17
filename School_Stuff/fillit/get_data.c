/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_data.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: acarole <acarole@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 23:23:42 by acarole           #+#    #+#             */
/*   Updated: 2019/12/07 16:57:03 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"

t_list	*get_tet_list(char *tetris)
{
	short	i;
	char	c;
	t_list	*tetri_list;
	t_tet	*tetri;

	tetri_list = NULL;
	tetri = NULL;
	c = 'A';
	i = 0;
	while (tetris[i])
	{
		tetri = get_block(&tetris[i], c);
		ft_list_add(&tetri_list, ft_list_new(tetri, sizeof(t_tet)));
		i += 19;
		if (tetris[i + 1] == '\n')
			i += 2;
		else
			break ;
		c++;
	}
	ft_list_rev(&tetri_list);
	return (tetri_list);
}

char	*read_file(char *argv)
{
	char	*str;
	char	*ptr;
	short	fd;

	fd = open(argv, O_RDONLY);
	if (fd == -1)
		return (0);
	str = 0;
	while (get_next_line(fd, &ptr))
	{
		ptr = ft_strjoin2(ptr, "\n");
		if (str)
			str = ft_strjoin2(str, ptr);
		else
			str = ft_strdup(ptr);
		free(ptr);
	}
	close(fd);
	return (str);
}
