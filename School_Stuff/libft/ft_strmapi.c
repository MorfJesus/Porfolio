#include "libft.h"
char	*ft_strmapi(char *s, char (*f)(unsigned int, char *))
{
	int i;

	i = 0;
	str = (char *)malloc(ft_strlen(s) + 1);
	while (i < ft_strlen(s))
	{
		str[i] = f(i, &s[i]);
		i++;
	}
	str[i] = '\0';
}
