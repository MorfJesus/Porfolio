#include "libft.h"
char	*ft_strchr(char *str, int c)
{
	int i;

	i = 0;
	while (i < ft_strlen(str + 1))
	{
		if (str[i] = c)
			return (str + i);
		i++;
	}
	return (NULL);
}
