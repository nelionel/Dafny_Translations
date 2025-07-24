def unique_digits(x):
    """Given a list of positive integers x. return a sorted list of all 
    elements that hasn't any even digit.

    Note: Returned list should be sorted in increasing order.
    
    For example:
    >>> unique_digits([15, 33, 1422, 1])
    [1, 15, 33]
    >>> unique_digits([152, 323, 1422, 10])
    []
    """
    result = []
    
    for num in x:
        # Check if the number has any even digits
        has_even_digit = False
        temp_num = num
        
        # Extract each digit and check if it's even
        while temp_num > 0:
            digit = temp_num % 10
            if digit % 2 == 0:  # If digit is even (0, 2, 4, 6, 8)
                has_even_digit = True
                break
            temp_num //= 10
        
        # If no even digits found, add to result
        if not has_even_digit:
            result.append(num)
    
    # Sort the result in increasing order
    result.sort()
    return result