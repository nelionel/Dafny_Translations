def largest_smallest_integers(lst):
    '''
    Create a function that returns a tuple (a, b), where 'a' is
    the largest of negative integers, and 'b' is the smallest
    of positive integers in a list.
    If there is no negative or positive integers, return them as None.

    Examples:
    largest_smallest_integers([2, 4, 1, 3, 5, 7]) == (None, 1)
    largest_smallest_integers([]) == (None, None)
    largest_smallest_integers([0]) == (None, None)
    '''
    
    # Filter negative and positive integers
    negative_integers = [x for x in lst if x < 0]
    positive_integers = [x for x in lst if x > 0]
    
    # Find largest negative (closest to 0) or None if no negatives
    largest_negative = max(negative_integers) if negative_integers else None
    
    # Find smallest positive (closest to 0) or None if no positives
    smallest_positive = min(positive_integers) if positive_integers else None
    
    return (largest_negative, smallest_positive)