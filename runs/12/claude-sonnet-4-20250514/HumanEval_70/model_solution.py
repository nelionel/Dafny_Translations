def strange_sort_list(lst):
    '''
    Given list of integers, return list in strange order.
    Strange sorting, is when you start with the minimum value,
    then maximum of the remaining integers, then minimum and so on.

    Examples:
    strange_sort_list([1, 2, 3, 4]) == [1, 4, 2, 3]
    strange_sort_list([5, 5, 5, 5]) == [5, 5, 5, 5]
    strange_sort_list([]) == []
    '''
    if not lst:
        return []
    
    remaining = lst.copy()  # Create a copy to avoid modifying the original list
    result = []
    take_min = True  # Flag to alternate between min and max
    
    while remaining:
        if take_min:
            value = min(remaining)
        else:
            value = max(remaining)
        
        remaining.remove(value)  # Remove the selected value
        result.append(value)     # Add it to result
        take_min = not take_min  # Toggle the flag
    
    return result