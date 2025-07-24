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
        # Convert number to string to check each digit
        num_str = str(num)
        
        # Check if any digit is even
        has_even_digit = False
        for digit in num_str:
            if int(digit) % 2 == 0:  # Check if digit is even
                has_even_digit = True
                break
        
        # If no even digits found, add to result
        if not has_even_digit:
            result.append(num)
    
    # Sort and return the result
    return sorted(result)