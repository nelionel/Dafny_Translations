def digits(n):
    """Given a positive integer n, return the product of the odd digits.
    Return 0 if all digits are even.
    For example:
    digits(1)  == 1
    digits(4)  == 0
    digits(235) == 15
    """
    product = 1
    has_odd_digit = False
    
    # Convert to string to easily iterate through digits
    for digit_char in str(n):
        digit = int(digit_char)
        
        # Check if digit is odd
        if digit % 2 == 1:
            product *= digit
            has_odd_digit = True
    
    # Return 0 if no odd digits were found
    return product if has_odd_digit else 0