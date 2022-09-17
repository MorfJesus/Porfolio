/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <eleanna@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/10 01:12:13 by eleanna           #+#    #+#             */
/*   Updated: 2019/12/07 16:30:13 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fillit.h"

int		main(int argc, char **argv)
{
	t_map	*map;
	char	*tetris;
	t_list	*tetri_list;

	if (argc != 2)
	{
		ft_putstr("usage: fillit input_file\n");
		return (0);
	}
	if ((tetris = read_file(argv[1])) == NULL)
	{
		ft_putstr("error\n");
		return (0);
	}
	ft_putstr(tetris);
	if (!check_all(tetris))
	{
		ft_putstr("error\n");
		return (0);
	}
	tetri_list = get_tet_list(tetris);
	map = solve(tetri_list);
	print_map(map);
	free_map(map);
	free_all_tetri(tetri_list);
	return (1);
}
