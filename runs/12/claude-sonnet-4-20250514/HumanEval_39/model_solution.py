def prime_fib(n: int):
    """
    prime_fib returns n-th number that is a Fibonacci number and it's also prime.
    >>> prime_fib(1)
    2
    >>> prime_fib(2)
    3
    >>> prime_fib(3)
    5
    >>> prime_fib(4)
    13
    >>> prime_fib(5)
    89
    """
    def is_prime(num):
        """Check if a number is prime"""
        if num < 2:
            return False
        if num == 2:
            return True
        if num % 2 == 0:
            return False
        for i in range(3, int(num**0.5) + 1, 2):
            if num % i == 0:
                return False
        return True
    
    count = 0  # Count of prime Fibonacci numbers found
    a, b = 0, 1  # Initial Fibonacci numbers
    
    while count < n:
        if is_prime(a):
            count += 1
            if count == n:
                return a
        # Generate next Fibonacci number
        a, b = b, a + b
    
    return None  # This should never be reached for valid input