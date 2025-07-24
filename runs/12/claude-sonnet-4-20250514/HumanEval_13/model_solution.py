def greatest_common_divisor(a: int, b: int) -> int:
    """ Return a greatest common divisor of two integers a and b
    >>> greatest_common_divisor(3, 5)
    1
    >>> greatest_common_divisor(25, 15)
    5
    """
    # Make sure we work with positive numbers
    a, b = abs(a), abs(b)
    
    # Euclid's algorithm
    while b != 0:
        a, b = b, a % b
    
    return a