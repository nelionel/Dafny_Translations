def starts_one_ends(n):
    """
    Given a positive integer n, return the count of the numbers of n-digit
    positive integers that start or end with 1.
    """
    if n == 1:
        # Only single digit numbers: 1, 2, 3, 4, 5, 6, 7, 8, 9
        # Only 1 starts or ends with 1
        return 1
    
    # For n > 1:
    # Numbers that start with 1: 1 followed by (n-1) digits
    # The remaining (n-1) positions can be any digit 0-9
    # So there are 10^(n-1) such numbers
    starts_with_1 = 10 ** (n - 1)
    
    # Numbers that end with 1: (n-1) digits followed by 1
    # The first digit can be 1-9 (not 0, since we need n-digit numbers)
    # The middle (n-2) digits can be 0-9
    # So there are 9 * 10^(n-2) such numbers
    ends_with_1 = 9 * (10 ** (n - 2))
    
    # Numbers that both start and end with 1: 1 + (n-2) middle digits + 1
    # The middle (n-2) digits can be any digit 0-9
    # So there are 10^(n-2) such numbers
    both_start_and_end_with_1 = 10 ** (n - 2)
    
    # Apply inclusion-exclusion principle
    return starts_with_1 + ends_with_1 - both_start_and_end_with_1