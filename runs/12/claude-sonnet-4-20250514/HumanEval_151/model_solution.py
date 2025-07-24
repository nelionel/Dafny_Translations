def double_the_difference(lst):
    '''
    Given a list of numbers, return the sum of squares of the numbers
    in the list that are odd. Ignore numbers that are negative or not integers.
    
    double_the_difference([1, 3, 2, 0]) == 1 + 9 + 0 + 0 = 10
    double_the_difference([-1, -2, 0]) == 0
    double_the_difference([9, -2]) == 81
    double_the_difference([0]) == 0  
   
    If the input list is empty, return 0.
    '''
    if not lst:  # Handle empty list
        return 0
    
    total = 0
    for num in lst:
        # Check if it's an integer (int type or float that represents a whole number)
        if isinstance(num, int) or (isinstance(num, float) and num.is_integer()):
            # Convert to int for consistency
            num = int(num)
            # Check if it's non-negative and odd
            if num >= 0 and num % 2 == 1:
                total += num ** 2
    
    return total