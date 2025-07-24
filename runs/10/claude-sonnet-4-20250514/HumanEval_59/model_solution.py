def largest_prime_factor(n: int):
    """Return the largest prime factor of n. Assume n > 1 and is not a prime.
    >>> largest_prime_factor(13195)
    29
    >>> largest_prime_factor(2048)
    2
    """
    largest_factor = 1
    
    # Check for factor 2
    while n % 2 == 0:
        largest_factor = 2
        n = n // 2
    
    # Check for odd factors starting from 3
    factor = 3
    while factor * factor <= n:
        while n % factor == 0:
            largest_factor = factor
            n = n // factor
        factor += 2
    
    # If n is still greater than 1, then it's a prime factor
    if n > 1:
        largest_factor = n
    
    return largest_factor