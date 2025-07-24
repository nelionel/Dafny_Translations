def starts_one_ends(n):
    """
    Given a positive integer n, return the count of the numbers of n-digit
    positive integers that start or end with 1.
    """
    if n == 1:
        return 1
    
    # Numbers that start with 1: 1 followed by (n-1) digits (0-9)
    starts_with_1 = 10 ** (n - 1)
    
    # Numbers that end with 1: first digit (1-9), middle digits (0-9), last digit 1
    ends_with_1 = 9 * (10 ** (n - 2))
    
    # Numbers that both start and end with 1: 1, middle digits (0-9), 1
    both_start_end_1 = 10 ** (n - 2)
    
    # Apply inclusion-exclusion principle
    return starts_with_1 + ends_with_1 - both_start_end_1