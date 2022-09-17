#include "libft.h"
int main(int argc, char **argv)
{
	printf("%d\n", ft_strlen(argv[1]));
	char *str = ft_strdup(argv[1]);
	printf("%c\n%c\n", ft_toupper(str[0]), ft_tolower(str[0]));
	ft_putendl_fd(str, 1);
	ft_putstr_fd(str, 2);
	ft_putchar_fd(str[0], 1);
}
