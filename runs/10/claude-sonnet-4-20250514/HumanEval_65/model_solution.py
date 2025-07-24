def circular_shift(x, shift):
    """Circular shift the digits of the integer x, shift the digits right by shift
    and return the result as a string.
    If shift > number of digits, return digits reversed.
    >>> circular_shift(12, 1)
    "21"
    >>> circular_shift(12, 2)
    "12"
    """
    # Convert to string to work with digits
    digits = str(abs(x))  # Use abs to handle negative numbers
    n = len(digits)
    
    # If shift is greater than number of digits, return reversed digits
    if shift > n:
        return digits[::-1]
    
    # Handle case where shift is 0 or multiple of n
    if shift == 0 or n == 0:
        return digits
    
    # Normalize shift to be within range [0, n)
    shift = shift % n
    
    # Perform circular right shift
    # Right shift by 'shift' means taking last 'shift' digits and moving them to front
    return digits[-shift:] + digits[:-shift]