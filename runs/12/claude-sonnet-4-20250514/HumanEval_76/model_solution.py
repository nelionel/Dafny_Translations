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
        return x == 1  # 1^k = 1 for any k, so only x=1 works
    
    if n == 0:
        return x == 0  # 0^k = 0 for k > 0
    
    if x == 1:
        return True  # Any n^0 = 1 (except when n=0, handled above)
    
    if x == 0:
        return False  # n^k = 0 only when n=0, already handled
    
    # For n = -1, only x = 1 or x = -1 work
    if n == -1:
        return x == 1 or x == -1
    
    # For other cases, use iterative approach
    if abs(n) > 1:
        power = 1
        # Try positive powers
        while abs(power) <= abs(x):
            if power == x:
                return True
            # Prevent overflow by checking if next multiplication would be too large
            if abs(power) > abs(x) // abs(n):
                break
            power *= n
        return False
    
    # For 0 < |n| < 1, x must be getting smaller with each power
    # This case is complex, so let's use a different approach
    if abs(n) < 1 and n != 0:
        # Try a few powers to see if we get x
        power = 1
        for i in range(100):  # Reasonable limit
            if abs(power - x) < 1e-10:  # Close enough due to floating point
                return True
            power *= n
            if abs(power) > abs(x) * 2:  # Getting too far
                break
        return False
    
    return False