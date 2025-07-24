from typing import List

def intersperse(numbers: List[int], delimeter: int) -> List[int]:
    """ Insert a number 'delimeter' between every two consecutive elements of input list `numbers'
    >>> intersperse([], 4)
    []
    >>> intersperse([1, 2, 3], 4)
    [1, 4, 2, 4, 3]
    """
    if not numbers:  # empty list case
        return []
    
    result = [numbers[0]]  # start with first element
    
    # For each remaining element, add delimiter then the element
    for i in range(1, len(numbers)):
        result.append(delimeter)
        result.append(numbers[i])
    
    return result