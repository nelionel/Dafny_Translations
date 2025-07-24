def add_elements(arr, k):
    """
    Given a non-empty array of integers arr and an integer k, return
    the sum of the elements with at most two digits from the first k elements of arr.

    Example:

        Input: arr = [111,21,3,4000,5,6,7,8,9], k = 4
        Output: 24 # sum of 21 + 3

    Constraints:
        1. 1 <= len(arr) <= 100
        2. 1 <= k <= len(arr)
    """
    # Take the first k elements
    first_k_elements = arr[:k]
    
    # Filter elements with at most two digits (absolute value <= 99)
    # Single digit: 0-9, Two digits: 10-99 (and their negative counterparts)
    valid_elements = [num for num in first_k_elements if abs(num) <= 99]
    
    # Return the sum of valid elements
    return sum(valid_elements)