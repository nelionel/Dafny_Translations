def circular_shift(x, shift):
    """Circular shift the digits of the integer x, shift the digits right by shift
    and return the result as a string.
    If shift > number of digits, return digits reversed.
    >>> circular_shift(12, 1)
    "21"
    >>> circular_shift(12, 2)
    "12"
    """
    s = str(x)
    n = len(s)
    
    if shift > n:
        return s[::-1]  # return digits reversed
    else:
        # Circular shift right by shift positions
        # Take the last 'shift' digits and move them to the front
        shift = shift % n  # handle edge cases
        if shift == 0:
            return s
        return s[-shift:] + s[:-shift]