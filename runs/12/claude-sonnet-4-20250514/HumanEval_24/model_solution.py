def largest_divisor(n: int) -> int:
    """ For a given number n, find the largest number that divides n evenly, smaller than n
    >>> largest_divisor(15)
    5
    """
    # Start from n-1 and work backwards to find the largest divisor
    for i in range(n - 1, 0, -1):
        if n % i == 0:
            return i
    
    # This should never be reached for n > 1, but just in case
    return 1