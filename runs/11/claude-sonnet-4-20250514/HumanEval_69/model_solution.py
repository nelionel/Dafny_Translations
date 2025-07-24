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
    
    # Find the greatest number where frequency >= value
    result = -1
    for value, freq in frequency.items():
        if freq >= value and value > result:
            result = value
    
    return result