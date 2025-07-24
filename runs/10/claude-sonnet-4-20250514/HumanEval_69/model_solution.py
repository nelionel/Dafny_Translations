def search(lst):
    '''
    You are given a non-empty list of positive integers. Return the greatest integer that is greater than 
    zero, and has a frequency greater than or equal to the value of the integer itself. 
    The frequency of an integer is the number of times it appears in the list.
    If no such a value exist, return -1.
    Examples:
        search([4, 1, 2, 2, 3, 1]) == 2
        search([1, 2, 2, 3, 3, 3, 4, 4, 4]) == 3
        search([5, 5, 4, 4, 4]) == -1
    '''
    # Count frequency of each number
    frequency = {}
    for num in lst:
        frequency[num] = frequency.get(num, 0) + 1
    
    # Find numbers where frequency >= value
    valid_numbers = []
    for num, freq in frequency.items():
        if freq >= num:
            valid_numbers.append(num)
    
    # Return the greatest valid number, or -1 if none exist
    if valid_numbers:
        return max(valid_numbers)
    else:
        return -1