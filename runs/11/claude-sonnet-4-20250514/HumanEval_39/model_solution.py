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
        """Check if a number is prime."""
        if num < 2:
            return False
        if num == 2:
            return True
        if num % 2 == 0:
            return False
        
        # Check odd divisors up to sqrt(num)
        i = 3
        while i * i <= num:
            if num % i == 0:
                return False
            i += 2
        return True
    
    def fibonacci_generator():
        """Generate Fibonacci numbers."""
        a, b = 0, 1
        while True:
            yield a
            a, b = b, a + b
    
    count = 0
    fib_gen = fibonacci_generator()
    
    for fib_num in fib_gen:
        if is_prime(fib_num):
            count += 1
            if count == n:
                return fib_num