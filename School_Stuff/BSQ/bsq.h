/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bsq.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: eleanna <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/22 18:16:41 by eleanna           #+#    #+#             */
/*   Updated: 2019/07/25 03:36:48 by eleanna          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef BSQ_H
# define BSQ_H
# include <stdlib.h>
# include <unistd.h>
# include <sys/types.h>
# include <sys/stat.h>
# include <fcntl.h>
# include "bsq.h"

char				*ft_realloc(char *str, unsigned long size);

void				ft_putstr(char *str);

unsigned short int	check(char *str, int i_s);

unsigned short int	iteration(char *str);

unsigned int		min(unsigned int x, unsigned int y);

unsigned short int	set_symb(char *str);

unsigned short int	temp_solution(char *str);

void				measure(char *str);

void				draw(char *str, int coord, unsigned short int a);

char				*ft_cut(char *src);

char				*ft_strcat(char *dest, char *src);

char	g_obst;

char	g_empt;

char	g_full;

unsigned int		g_x;

unsigned int		g_y;

unsigned int		g_a_new;

unsigned short int	g_flag;

#endif
