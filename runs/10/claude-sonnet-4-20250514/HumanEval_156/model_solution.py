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
    # Define the Roman numeral values and their corresponding symbols
    # Listed in descending order to handle subtractive cases properly
    values = [
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4,
        1
    ]
    
    symbols = [
        'M', 'CM', 'D', 'CD',
        'C', 'XC', 'L', 'XL',
        'X', 'IX', 'V', 'IV',
        'I'
    ]
    
    result = ""
    
    # Process each value-symbol pair
    for i in range(len(values)):
        # Add the symbol as many times as the value fits into the number
        count = number // values[i]
        if count > 0:
            result += symbols[i] * count
            number -= values[i] * count
    
    return result.lower()