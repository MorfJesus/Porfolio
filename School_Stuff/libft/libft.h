# ifndef LIBFT_H
# define LIBFT_H
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int	ft_strlen(char *str);

char	*ft_strdup(char *strl);

int     ft_isalpha(char c);

int	ft_isdigit(char c);

int	ft_isalnum(char c);

int	ft_isascii(char c);

int	ft_toupper(int c);

int	ft_tolower(int c);

void	ft_putchar(char c);

void	ft_putstr(char *str);

void	ft_putendl(char *str);

void	ft_putchar_fd(char c, int fd);

void	ft_putstr_fd(char *str, int fd);

void	ft_putendl_fd(char *str, int fd);
# endif
