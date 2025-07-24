def greatest_common_divisor(a: int, b: int) -> int:
    """ Return a greatest common divisor of two integers a and b
    >>> greatest_common_divisor(3, 5)
    1
    >>> greatest_common_divisor(25, 15)
    5
    """
    # Handle edge cases where one or both numbers are 0
    if a == 0:
        return abs(b)
    if b == 0:
        return abs(a)
    
    # Make both numbers positive for the algorithm
    a, b = abs(a), abs(b)
    
    # Euclidean algorithm
    while b != 0:
        a, b = b, a % b
    
    return a