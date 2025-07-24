def x_or_y(n, x, y):
    """A simple program which should return the value of x if n is 
    a prime number and should return the value of y otherwise.

    Examples:
    for x_or_y(7, 34, 12) == 34
    for x_or_y(15, 8, 5) == 5
    
    """
    def is_prime(num):
        """Helper function to check if a number is prime"""
        if num < 2:
            return False
        if num == 2:
            return True
        if num % 2 == 0:
            return False
        
        # Check odd divisors up to sqrt(num)
        for i in range(3, int(num ** 0.5) + 1, 2):
            if num % i == 0:
                return False
        return True
    
    # Return x if n is prime, otherwise return y
    if is_prime(n):
        return x
    else:
        return y