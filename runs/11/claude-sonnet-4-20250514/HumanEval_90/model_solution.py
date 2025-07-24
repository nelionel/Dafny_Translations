def next_smallest(lst):
    """
    You are given a list of integers.
    Write a function next_smallest() that returns the 2nd smallest element of the list.
    Return None if there is no such element.
    
    next_smallest([1, 2, 3, 4, 5]) == 2
    next_smallest([5, 1, 4, 3, 2]) == 2
    next_smallest([]) == None
    next_smallest([1, 1]) == None
    """
    # Handle empty list
    if not lst:
        return None
    
    # Get unique elements
    unique_elements = list(set(lst))
    
    # If we have less than 2 unique elements, return None
    if len(unique_elements) < 2:
        return None
    
    # Sort the unique elements and return the second smallest
    unique_elements.sort()
    return unique_elements[1]