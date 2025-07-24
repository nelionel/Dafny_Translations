def is_sorted(lst):
    '''
    Given a list of numbers, return whether or not they are sorted
    in ascending order. If list has more than 1 duplicate of the same
    number, return False. Assume no negative numbers and only integers.

    Examples
    is_sorted([5]) ➞ True
    is_sorted([1, 2, 3, 4, 5]) ➞ True
    is_sorted([1, 3, 2, 4, 5]) ➞ False
    is_sorted([1, 2, 3, 4, 5, 6]) ➞ True
    is_sorted([1, 2, 3, 4, 5, 6, 7]) ➞ True
    is_sorted([1, 3, 2, 4, 5, 6, 7]) ➞ False
    is_sorted([1, 2, 2, 3, 3, 4]) ➞ True
    is_sorted([1, 2, 2, 2, 3, 4]) ➞ False
    '''
    # Handle empty list or single element
    if len(lst) <= 1:
        return True
    
    # Check if list is sorted in ascending order
    for i in range(1, len(lst)):
        if lst[i] < lst[i-1]:
            return False
    
    # Count occurrences of each number
    from collections import Counter
    counts = Counter(lst)
    
    # Check if any number appears more than twice
    for count in counts.values():
        if count > 2:
            return False
    
    return True