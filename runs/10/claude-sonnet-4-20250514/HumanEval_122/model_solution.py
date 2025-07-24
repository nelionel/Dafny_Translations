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
    # Get the first k elements
    first_k_elements = arr[:k]
    
    # Filter elements with at most two digits
    # A number has at most two digits if its absolute value is <= 99
    valid_elements = [num for num in first_k_elements if abs(num) <= 99]
    
    # Return the sum
    return sum(valid_elements)