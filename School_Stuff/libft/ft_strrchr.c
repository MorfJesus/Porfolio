#include "libft.h"
char	*ft_strrchr(char *str, int c)
{
	int i;

	i = ft_strlen(str);
	while (i != 0)
	{
		if (str[i] = c)
			return (str + i);
		i--;
	}
	return (NULL);
}
