def is_simple_power(x, n):
    """Your task is to write a function that returns true if a number x is a simple
    power of n and false in other cases.
    x is a simple power of n if n**int=x
    For example:
    is_simple_power(1, 4) => true
    is_simple_power(2, 2) => true
    is_simple_power(8, 2) => true
    is_simple_power(3, 2) => false
    is_simple_power(3, 1) => false
    is_simple_power(5, 3) => false
    """
    # Handle edge cases
    if n == 1:
        return x == 1
    
    if x == 1:
        return True  # Any number to the power of 0 equals 1
    
    if n == 0:
        return False  # 0 raised to any positive power is 0, but we need x > 0
    
    if x <= 0 or n <= 0:
        return False
    
    # Use logarithms to find the potential exponent
    import math
    
    try:
        # Calculate log_n(x) = log(x) / log(n)
        exponent = math.log(x) / math.log(n)
        
        # Check if the exponent is close to an integer
        rounded_exponent = round(exponent)
        
        # Verify by checking if n^rounded_exponent equals x
        return abs(n ** rounded_exponent - x) < 1e-10
        
    except (ValueError, ZeroDivisionError):
        return False