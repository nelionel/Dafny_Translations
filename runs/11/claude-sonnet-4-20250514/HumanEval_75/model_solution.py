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
        for i in range(2, int(n ** 0.5) + 1):
            if n % i == 0:
                return False
        return True
    
    def get_prime_factors(n):
        """Get all prime factors of n (with repetition)"""
        factors = []
        d = 2
        while d * d <= n:
            while n % d == 0:
                factors.append(d)
                n //= d
            d += 1
        if n > 1:
            factors.append(n)
        return factors
    
    # Handle edge cases
    if a <= 1:
        return False
    
    # Get all prime factors
    prime_factors = get_prime_factors(a)
    
    # Check if we have exactly 3 prime factors
    return len(prime_factors) == 3