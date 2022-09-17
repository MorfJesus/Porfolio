#include "libft.h"
char	*ft_strdup(char *strl)
{
	char	*str;
	int	i;

	i = 0;
	if (!strl)
		return (NULL);
	str = (char *)malloc(ft_strlen(strl) + 1);
	while (strl[i])
	{
		str[i] = strl[i];
		i++;
	}
	str[i] = '\0';
	return (str);
}
