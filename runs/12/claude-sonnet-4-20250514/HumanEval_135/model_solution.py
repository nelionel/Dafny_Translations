def can_arrange(arr):
    """Create a function which returns the largest index of an element which
    is not greater than or equal to the element immediately preceding it. If
    no such element exists then return -1. The given array will not contain
    duplicate values.

    Examples:
    can_arrange([1,2,4,3,5]) = 3
    can_arrange([1,2,3]) = -1
    """
    largest_index = -1
    
    # Start from index 1 since we need to compare with preceding element
    for i in range(1, len(arr)):
        # Check if current element is smaller than previous element
        if arr[i] < arr[i-1]:
            largest_index = i
    
    return largest_index