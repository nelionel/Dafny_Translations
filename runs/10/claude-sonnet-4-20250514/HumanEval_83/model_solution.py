def starts_one_ends(n):
    """
    Given a positive integer n, return the count of the numbers of n-digit
    positive integers that start or end with 1.
    """
    if n <= 0:
        return 0
    
    if n == 1:
        return 1  # Only the number "1"
    
    # Numbers that start with 1: 1 followed by (n-1) digits
    # The remaining (n-1) digits can be anything from 0-9
    starts_with_1 = 10 ** (n - 1)
    
    # Numbers that end with 1: (n-1) digits followed by 1
    # The first digit can be 1-9 (not 0, as we need n-digit numbers)
    # The remaining (n-2) digits can be anything from 0-9
    ends_with_1 = 9 * (10 ** (n - 2))
    
    # Numbers that both start and end with 1: 1 followed by (n-2) digits followed by 1
    # The middle (n-2) digits can be anything from 0-9
    if n == 2:
        starts_and_ends_with_1 = 1  # Only "11"
    else:
        starts_and_ends_with_1 = 10 ** (n - 2)
    
    # Apply inclusion-exclusion principle
    result = starts_with_1 + ends_with_1 - starts_and_ends_with_1
    
    return result