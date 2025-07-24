def is_multiply_prime(a):
    """Write a function that returns true if the given number is the multiplication of 3 prime numbers
    and false otherwise.
    Knowing that (a) is less then 100. 
    Example:
    is_multiply_prime(30) == True
    30 = 2 * 3 * 5
    """
    if a < 2:
        return False
    
    # Count prime factors (including repetitions)
    factor_count = 0
    temp = a
    
    # Check for factor 2
    while temp % 2 == 0:
        factor_count += 1
        temp //= 2
    
    # Check for odd factors from 3 onwards
    i = 3
    while i * i <= temp:
        while temp % i == 0:
            factor_count += 1
            temp //= i
        i += 2
    
    # If temp is still greater than 1, then it's a prime factor
    if temp > 1:
        factor_count += 1
    
    return factor_count == 3