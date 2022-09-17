#include "libft.h"
char	*ft_strmap(char *s, char (*f)(char *))
{
	int i;

	i = 0;
	str = (char *)malloc(ft_strlen(s) + 1);
	while (i < ft_strlen(s))
	{
		str[i] = f(&s[i]);
		i++;
	}
	str[i] = '\0';
}
