def order_by_points(nums):
    """
    Write a function which sorts the given list of integers
    in ascending order according to the sum of their digits.
    Note: if there are several items with similar sum of their digits,
    order them based on their index in original list.

    For example:
    >>> order_by_points([1, 11, -1, -11, -12]) == [-1, -11, 1, -12, 11]
    >>> order_by_points([]) == []
    """
    def digit_sum(n):
        if n == 0:
            return 0
        
        # Convert to string of absolute value to get digits
        s = str(abs(n))
        total = 0
        
        for i, digit in enumerate(s):
            if n < 0 and i == 0:
                # For negative numbers, first digit is negative
                total -= int(digit)
            else:
                # All other digits are positive
                total += int(digit)
        
        return total
    
    # Create list of (value, original_index) pairs
    indexed_nums = [(num, i) for i, num in enumerate(nums)]
    
    # Sort by digit sum first, then by original index
    indexed_nums.sort(key=lambda x: (digit_sum(x[0]), x[1]))
    
    # Extract just the values
    return [num for num, _ in indexed_nums]