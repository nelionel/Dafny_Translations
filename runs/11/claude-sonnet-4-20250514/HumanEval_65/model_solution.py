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
    
    # If shift is greater than number of digits, return reversed
    if shift > n:
        return digits[::-1]
    
    # Perform circular right shift
    # shift % n handles cases where shift >= n
    shift = shift % n
    
    # Right shift: take last 'shift' digits and move to front
    if shift == 0:
        return digits
    
    return digits[-shift:] + digits[:-shift]