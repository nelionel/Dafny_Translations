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
    
    # Create a copy to avoid modifying the original list
    remaining = lst.copy()
    result = []
    pick_min = True  # Start with minimum
    
    while remaining:
        if pick_min:
            value = min(remaining)
        else:
            value = max(remaining)
        
        result.append(value)
        remaining.remove(value)  # Remove first occurrence
        pick_min = not pick_min  # Alternate between min and max
    
    return result