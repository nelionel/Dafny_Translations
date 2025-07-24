def closest_integer(value):
    '''
    Create a function that takes a value (string) representing a number
    and returns the closest integer to it. If the number is equidistant
    from two integers, round it away from zero.

    Examples
    >>> closest_integer("10")
    10
    >>> closest_integer("15.3")
    15

    Note:
    Rounding away from zero means that if the given number is equidistant
    from two integers, the one you should return is the one that is the
    farthest from zero. For example closest_integer("14.5") should
    return 15 and closest_integer("-14.5") should return -15.
    '''
    # Convert string to float
    num = float(value)
    
    # Get the fractional part
    fractional_part = abs(num - int(num))
    
    # Check if the number is equidistant from two integers (fractional part is 0.5)
    if abs(fractional_part - 0.5) < 1e-9:  # Using small epsilon for floating point comparison
        # Round away from zero
        if num >= 0:
            return int(num) + 1
        else:
            return int(num) - 1
    else:
        # Normal rounding
        return round(num)