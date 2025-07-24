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
    def has_only_odd_digits(num):
        """Check if a number contains only odd digits"""
        for digit_char in str(num):
            digit = int(digit_char)
            if digit % 2 == 0:  # even digit found
                return False
        return True
    
    # Filter numbers that have only odd digits and sort the result
    result = [num for num in x if has_only_odd_digits(num)]
    return sorted(result)