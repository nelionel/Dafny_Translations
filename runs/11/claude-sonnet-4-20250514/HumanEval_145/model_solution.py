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
        # Convert to string to work with digits
        s = str(abs(n))  # Get absolute value to work with digits
        
        # Calculate sum of digits
        total = sum(int(digit) for digit in s)
        
        # If original number was negative, make the first digit negative
        if n < 0:
            first_digit = int(s[0])
            total = total - 2 * first_digit  # Subtract twice to make first digit negative
        
        return total
    
    # Create list of (original_index, number, digit_sum) tuples
    indexed_nums = [(i, num, digit_sum(num)) for i, num in enumerate(nums)]
    
    # Sort by digit sum first, then by original index to maintain stable sort
    indexed_nums.sort(key=lambda x: (x[2], x[0]))
    
    # Return just the numbers in the new order
    return [num for _, num, _ in indexed_nums]