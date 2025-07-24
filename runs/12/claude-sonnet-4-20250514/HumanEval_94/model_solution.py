def skjkasdkd(lst):
    """You are given a list of integers.
    You need to find the largest prime value and return the sum of its digits.
    """
    
    def is_prime(n):
        """Check if a number is prime"""
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
    
    def sum_of_digits(n):
        """Calculate the sum of digits of a number"""
        return sum(int(digit) for digit in str(n))
    
    # Find all prime numbers in the list
    primes = [num for num in lst if is_prime(num)]
    
    # If no primes found, return 0
    if not primes:
        return 0
    
    # Find the largest prime
    largest_prime = max(primes)
    
    # Return the sum of its digits
    return sum_of_digits(largest_prime)