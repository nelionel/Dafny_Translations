def sort_array(array):
    """
    Given an array of non-negative integers, return a copy of the given array after sorting,
    you will sort the given array in ascending order if the sum( first index value, last index value) is odd,
    or sort it in descending order if the sum( first index value, last index value) is even.

    Note:
    * don't change the given array.

    Examples:
    * sort_array([]) => []
    * sort_array([5]) => [5]
    * sort_array([2, 4, 3, 0, 1, 5]) => [0, 1, 2, 3, 4, 5]
    * sort_array([2, 4, 3, 0, 1, 5, 6]) => [6, 5, 4, 3, 2, 1, 0]
    """
    # Handle edge cases
    if len(array) <= 1:
        return array.copy()
    
    # Calculate sum of first and last elements
    first_last_sum = array[0] + array[-1]
    
    # Create a copy of the array
    array_copy = array.copy()
    
    # Sort based on whether sum is odd or even
    if first_last_sum % 2 == 1:  # odd sum
        array_copy.sort()  # ascending order
    else:  # even sum
        array_copy.sort(reverse=True)  # descending order
    
    return array_copy