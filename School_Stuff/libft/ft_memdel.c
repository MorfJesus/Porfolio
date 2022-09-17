#include "libft.h"
void	ft_memdel(void **as)
{
	free(*as);
	as = NULL;
}
