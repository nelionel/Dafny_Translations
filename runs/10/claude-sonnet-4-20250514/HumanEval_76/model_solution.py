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
    
    if n == 0:
        return x == 0
    
    if x == 1:
        return True  # n^0 = 1 for any n != 0
    
    if x == 0:
        return False  # n^k = 0 only when n = 0, but we handled that case above
    
    if n < 0:
        # For negative n, we need to check if x can be expressed as n^k
        # This is more complex, but we can still use the logarithm approach
        if x < 0:
            # Both negative: check if (-n)^k = -x for odd k, or (-n)^k = x for even k
            # Try to find if there's an integer k such that n^k = x
            import math
            try:
                k = math.log(abs(x)) / math.log(abs(n))
                if abs(k - round(k)) < 1e-10:  # k is close to an integer
                    k = round(k)
                    return n ** k == x
            except (ValueError, ZeroDivisionError):
                pass
            return False
        else:
            # n negative, x positive: n^k = x only if k is even
            import math
            try:
                k = math.log(x) / math.log(abs(n))
                if abs(k - round(k)) < 1e-10:  # k is close to an integer
                    k = round(k)
                    return k % 2 == 0 and (abs(n) ** k) == x
            except (ValueError, ZeroDivisionError):
                pass
            return False
    
    # For positive n and x
    if x < 0:
        return False  # positive n raised to any power cannot give negative result
    
    # Use logarithms to check if log_n(x) is an integer
    import math
    try:
        k = math.log(x) / math.log(n)
        # Check if k is close to an integer
        if abs(k - round(k)) < 1e-10:
            k = round(k)
            # Verify by computing n^k
            return abs(n ** k - x) < 1e-10
        return False
    except (ValueError, ZeroDivisionError):
        return False