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
    # Include subtractive cases (4, 9, 40, 90, 400, 900)
    values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    numerals = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I']
    
    result = ''
    
    # Process each value-numeral pair
    for i in range(len(values)):
        # Add the numeral as many times as the value fits into the number
        count = number // values[i]
        if count > 0:
            result += numerals[i] * count
            number -= values[i] * count
    
    # Return in lowercase as required
    return result.lower()