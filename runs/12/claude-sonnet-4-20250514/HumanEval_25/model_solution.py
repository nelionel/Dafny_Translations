from typing import List

def factorize(n: int) -> List[int]:
    """ Return list of prime factors of given integer in the order from smallest to largest.
    Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
    Input number should be equal to the product of all factors
    >>> factorize(8)
    [2, 2, 2]
    >>> factorize(25)
    [5, 5]
    >>> factorize(70)
    [2, 5, 7]
    """
    if n <= 1:
        return []
    
    factors = []
    factor = 2
    
    # Check all potential factors up to sqrt(n)
    while factor * factor <= n:
        # While n is divisible by current factor, add it to result
        while n % factor == 0:
            factors.append(factor)
            n //= factor
        factor += 1
    
    # If n > 1, then it's a prime factor itself
    if n > 1:
        factors.append(n)
    
    return factors