def generate_integers(a, b):
    """
    Given two positive integers a and b, return the even digits between a
    and b, in ascending order.

    For example:
    generate_integers(2, 8) => [2, 4, 6, 8]
    generate_integers(8, 2) => [2, 4, 6, 8]
    generate_integers(10, 14) => []
    """
    # Find the range boundaries
    min_val = min(a, b)
    max_val = max(a, b)
    
    # Check each even digit (0, 2, 4, 6, 8) to see if it falls in the range
    even_digits = []
    for digit in [0, 2, 4, 6, 8]:
        if min_val <= digit <= max_val:
            even_digits.append(digit)
    
    return even_digits