def generate_integers(a, b):
    """
    Given two positive integers a and b, return the even digits between a
    and b, in ascending order.

    For example:
    generate_integers(2, 8) => [2, 4, 6, 8]
    generate_integers(8, 2) => [2, 4, 6, 8]
    generate_integers(10, 14) => []
    """
    # Ensure we have the correct range regardless of order
    min_val = min(a, b)
    max_val = max(a, b)
    
    # Even digits are 0, 2, 4, 6, 8
    even_digits = [0, 2, 4, 6, 8]
    
    # Find even digits that fall within the range [min_val, max_val]
    result = []
    for digit in even_digits:
        if min_val <= digit <= max_val:
            result.append(digit)
    
    return result