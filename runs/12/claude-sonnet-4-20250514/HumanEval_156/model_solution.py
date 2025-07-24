def int_to_mini_roman(number):
    """
    Given a positive integer, obtain its roman numeral equivalent as a string,
    and return it in lowercase.
    Restrictions: 1 <= num <= 1000

    Examples:
    >>> int_to_mini_roman(19) == 'xix'
    >>> int_to_mini_roman(152) == 'clii'
    >>> int_to_mini_roman(426) == 'cdxxvi'
    """
    # Define the mapping from integers to Roman numerals in descending order
    # Include subtractive notation cases (IV, IX, XL, XC, CD, CM)
    val_to_roman = [
        (1000, 'M'),
        (900, 'CM'),
        (500, 'D'),
        (400, 'CD'),
        (100, 'C'),
        (90, 'XC'),
        (50, 'L'),
        (40, 'XL'),
        (10, 'X'),
        (9, 'IX'),
        (5, 'V'),
        (4, 'IV'),
        (1, 'I')
    ]
    
    result = ""
    
    # Process each value-roman pair from largest to smallest
    for value, roman in val_to_roman:
        count = number // value  # How many times this value fits
        if count:
            result += roman * count  # Add the roman numeral that many times
            number -= value * count  # Subtract the value we've accounted for
    
    return result.lower()