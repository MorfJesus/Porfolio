#include "libft.h"
void	*ft_memalloc(size_t size)
{
	void *mem;

	mem = malloc(size);
	if (!mem)
		return (NULL);
	mem = 0;
	return (mem);
}
