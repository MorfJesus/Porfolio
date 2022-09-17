#include "libft.h"
char	*ft_strsub(char const *s, unsigned int start, size_t size)
{
	int	i;
	char	*str;

	i = 0;
	str = (char *)malloc(size + 1);
	if (!str)
		return (NULL);
	while (i < size)
	{
		str[i] = s[start + i];
		i++;
	}
	str[i] = '\0';
}
