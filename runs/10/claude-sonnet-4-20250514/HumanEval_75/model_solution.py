def is_multiply_prime(a):
    """Write a function that returns true if the given number is the multiplication of 3 prime numbers
    and false otherwise.
    Knowing that (a) is less then 100. 
    Example:
    is_multiply_prime(30) == True
    30 = 2 * 3 * 5
    """
    
    def is_prime(n):
        """Helper function to check if a number is prime"""
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                return False
        return True
    
    # Handle edge cases
    if a < 8:  # Minimum product of 3 primes is 2*2*2 = 8
        return False
    
    # Count prime factors
    prime_factor_count = 0
    temp = a
    
    # Check for factor 2
    while temp % 2 == 0:
        prime_factor_count += 1
        temp //= 2
    
    # Check for odd prime factors
    i = 3
    while i * i <= temp:
        while temp % i == 0:
            prime_factor_count += 1
            temp //= i
        i += 2
    
    # If temp > 1, then it's a prime factor
    if temp > 1:
        prime_factor_count += 1
    
    return prime_factor_count == 3