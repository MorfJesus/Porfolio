/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 17:47:17 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 18:29:43 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq.h"

char	*create_array(char *argv, unsigned int buf, unsigned int i)
{
	char				*str;
	char				c;
	int					fd;

	str = malloc(sizeof(char));
	if (str == NULL)
		return (0);
	fd = open(argv, O_RDONLY);
	if (fd == -1)
		return (0);
	while (read(fd, &c, 1))
	{
		if (i >= buf)
		{
			buf = buf * 2;
			str = ft_realloc(str, buf + 1);
			if (str == NULL)
				return (0);
		}
		str[i] = c;
		i++;
	}
	str[i] = '\0';
	close(fd);
	return (str);
}

void	helping_fun(char *argv, int mode)
{
	char				*str;

	if (mode)
	{
		str = create_array(argv, 1, 0);
		if (str != 0)
			str = ft_cut(str);
	}
	else
		str = argv;
	measure(str);
	if (check(str, set_symb(str)))
	{
		if (!g_flag)
			draw(str + temp_solution(str), 0, min(g_x, g_y));
		else
			iteration(str + temp_solution(str));
		ft_putstr(str + temp_solution(str));
	}
	else
		write(2, "map error\n", 11);
	if (mode)
		free(str);
}

void	std_in(char *str)
{
	int		i;
	int		buf;
	char	c;

	i = 0;
	buf = 1;
	str = malloc(sizeof(char) * buf);
	if (str == NULL)
	{
		write(2, "map error\n", 11);
		return ;
	}
	while (read(0, &c, 1))
	{
		if (i >= buf)
		{
			buf = buf * 2;
			str = ft_realloc(str, buf + 1);
		}
		str[i] = c;
		i++;
	}
	str[i] = '\0';
	helping_fun(str, 0);
}

int		main(int argc, char **argv)
{
	int		i;
	char	*str;

	i = 1;
	if (argc >= 2)
		while (i < argc)
		{
			helping_fun(argv[i], 1);
			i++;
		}
	else
	{
		str = 0;
		std_in(str);
	}
}
