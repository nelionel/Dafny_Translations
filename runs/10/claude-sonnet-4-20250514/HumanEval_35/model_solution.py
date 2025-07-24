def max_element(l: list):
    """Return maximum element in the list.
    >>> max_element([1, 2, 3])
    3
    >>> max_element([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10])
    123
    """
    if not l:  # Handle empty list case
        raise ValueError("Cannot find maximum of empty list")
    
    max_val = l[0]
    for element in l[1:]:
        if element > max_val:
            max_val = element
    
    return max_val