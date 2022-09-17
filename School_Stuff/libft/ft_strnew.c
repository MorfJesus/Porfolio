#include "libft.h"
char	*ft_strnew(size_t size)
{
	char *str;
	int i;

	i = 0;
	str = (char *)malloc(size + 1);
	if (!str)
		return (NULL);
	while (i <= size)
	{
		str[i] = '\0';
		i++;
	}
	return (str);
}
