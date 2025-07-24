def sort_even(l: list):
    """This function takes a list l and returns a list l' such that
    l' is identical to l in the odd indicies, while its values at the even indicies are equal
    to the values of the even indicies of l, but sorted.
    >>> sort_even([1, 2, 3])
    [1, 2, 3]
    >>> sort_even([5, 6, 3, 4])
    [3, 6, 5, 4]
    """
    # Extract values at even indices
    even_values = [l[i] for i in range(0, len(l), 2)]
    
    # Sort the even values
    even_values.sort()
    
    # Create the result list
    result = []
    even_idx = 0
    
    for i in range(len(l)):
        if i % 2 == 0:  # Even index
            result.append(even_values[even_idx])
            even_idx += 1
        else:  # Odd index
            result.append(l[i])
    
    return result