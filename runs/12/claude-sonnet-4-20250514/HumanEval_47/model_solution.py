def median(l: list):
    """Return median of elements in the list l.
    >>> median([3, 1, 2, 4, 5])
    3
    >>> median([-10, 4, 6, 1000, 10, 20])
    15.0
    """
    # Sort the list
    sorted_list = sorted(l)
    n = len(sorted_list)
    
    # If odd number of elements, return middle element
    if n % 2 == 1:
        return sorted_list[n // 2]
    
    # If even number of elements, return average of two middle elements
    else:
        mid1 = sorted_list[n // 2 - 1]
        mid2 = sorted_list[n // 2]
        return (mid1 + mid2) / 2