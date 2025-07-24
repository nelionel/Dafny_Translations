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
        # Convert to string to handle digits
        s = str(abs(n))  # Use absolute value to get digits
        total = sum(int(digit) for digit in s)
        
        # For negative numbers, subtract the first digit once more
        # This accounts for the negative sign affecting the first digit
        if n < 0:
            total -= 2 * int(s[0])
        
        return total
    
    # Create list of (original_index, number, digit_sum) tuples
    indexed_nums = [(i, num, digit_sum(num)) for i, num in enumerate(nums)]
    
    # Sort by digit sum first, then by original index for stability
    indexed_nums.sort(key=lambda x: (x[2], x[0]))
    
    # Extract just the numbers from the sorted list
    return [num for _, num, _ in indexed_nums]