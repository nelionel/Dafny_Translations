def choose_num(x, y):
    """This function takes two positive numbers x and y and returns the
    biggest even integer number that is in the range [x, y] inclusive. If 
    there's no such number, then the function should return -1.

    For example:
    choose_num(12, 15) = 14
    choose_num(13, 12) = -1
    """
    # If x > y, there's no valid range
    if x > y:
        return -1
    
    # Find the largest even number <= y
    if y % 2 == 0:
        # If y is even, it's the largest even number
        largest_even = y
    else:
        # If y is odd, the largest even number is y-1
        largest_even = y - 1
    
    # Check if this even number is within our range [x, y]
    if largest_even >= x:
        return largest_even
    else:
        return -1