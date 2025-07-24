def is_prime(n):
    """Return true if a given number is prime, and false otherwise.
    >>> is_prime(6)
    False
    >>> is_prime(101)
    True
    >>> is_prime(11)
    True
    >>> is_prime(13441)
    True
    >>> is_prime(61)
    True
    >>> is_prime(4)
    False
    >>> is_prime(1)
    False
    """
    # Numbers less than or equal to 1 are not prime
    if n <= 1:
        return False
    
    # 2 is the only even prime number
    if n == 2:
        return True
    
    # All other even numbers are not prime
    if n % 2 == 0:
        return False
    
    # Check for odd divisors from 3 to sqrt(n)
    # We only need to check up to sqrt(n) because if n has a divisor greater than sqrt(n),
    # it must also have a corresponding divisor less than sqrt(n)
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    
    return True